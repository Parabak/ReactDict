//
//  LessonViewModel.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 28/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit


class LessonViewModel {
    
    private let dictionary: Observable<Dictionary>
    private let coordinator: SceneCoordinatorType
    let rx_disposeBag = DisposeBag()
    
    
    init(dictionary: Observable<Dictionary>, coordinator: SceneCoordinatorType) {
        
        self.dictionary = dictionary
        self.coordinator = coordinator
    }
    

    typealias Option = (type: Exercise, title: String)
    var excercises: Observable<Option> {

        dictionary.flatMap { dictionary -> Observable<Option> in
            
            let options = Exercise.allCases.map { exercise -> Option in
                return (exercise, exercise.nameSuitableFor(dictionary: dictionary))
            }
            return Observable.from(options)
        }
    }
    
    
    var rxStartExercise: AnyObserver<Exercise> {

        return Binder(self) { (viewModel, exercise) in
            
            viewModel.dictionary
            .flatMap { (dict) -> Observable<(Dictionary, Set<String>)> in
                    
                let progress = ProgressService(dictionary: dict.from)
                
                return Observable.combineLatest(Observable.just(dict),
                                                progress.completedWordsFor(exercise: exercise))
            }
            .map({ (dict, learnedSet) -> TranslateExerciseViewModel in
                   
                //TODO: Extract logic into separate method
                //TODO: Either allow Random PartOfSpeech OR implement picker!
                //TODO: These constants should be defined somewhere else e.g. Configuration
                let pos = PartOfSpeech.verb //PartOfSpeech.allCases.randomElement() ?? PartOfSpeech.noun
                let wordsPerExercise = 7
                let wrongPairs = 4
                
                let words = dict.words
                    .filter { word in word.partOfSpeech == pos && !learnedSet.contains(word.uuid)}
                    .shuffled()
                let trainingSet = Array(words.prefix(wordsPerExercise))
                
                let wrongAnswers = words
                    .dropFirst(wordsPerExercise)
                    .shuffled()
                    .prefix(wordsPerExercise * wrongPairs)
                    .compactMap { exercise == .directTranslate ? $0.translate.first : $0.word}
                
                let model = TranslateExerciseViewModel(trainingSet: trainingSet,
                                                       answersDiversity: wrongAnswers,
                                                       exercise: exercise)
                //TODO: extract this logic into method
                
                let results = Observable.zip(Observable.from(trainingSet),
                                             model.answers.asObservable())
                .map { (word, answer) -> (Word, Bool) in
                        
                    let result: Bool
                    switch exercise {
                    case .directTranslate:
                        result = word.translate.contains(answer)
                    case .reversedTranslate:
                        result = word.word == answer
                    }
                    return (word, result)
                }.flatMap { (word, result) -> Observable<(Word, Bool, Int)> in
                    
                    let service = ProgressService(dictionary: dict.from)
                    return Observable.zip(Observable.of(word),
                                          Observable.of(result),
                                          service.logAttempt(result: result,
                                                             word: word,
                                                             exercise: exercise))
                }
                .map({ (word, result, counter) -> TranslateResult in
                    TranslateResult(word: word,
                                    result: result,
                                    successfulAnswers: counter,
                                    exercise: exercise)
                })
                .share()
                
                
                results
                    .reduce([TranslateResult]()) { (accumulator, seed) -> [TranslateResult] in
                        return Array(accumulator+[seed])
                    }
                    .subscribe(onNext: { all in
                    
                        let resultModel = LessonResultViewModel(results: all)
                        viewModel.coordinator.transition(to: .lessonResult(resultModel),
                                                     type: .push)
                    })
                    .disposed(by: viewModel.rx_disposeBag)

                return model
            })
            .subscribe(onNext: { (translateExercise) in
                
                viewModel.coordinator.transition(to: .translateExercise(translateExercise),
                                                 type: .push)
            })
            .disposed(by: viewModel.rx_disposeBag)
            
        }.asObserver()
    }
}
