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
            .flatMap { (dict) -> Observable<(Dictionary, Set<Int>)> in
                    
                let progress = ProgressService(dictionary: dict.from)
                
                return Observable.combineLatest(Observable.just(dict),
                                                progress.completedWordsFor(exercise: exercise))
            }
            .map({ (dict, learnedSet) -> TranslateExerciseViewModel in
                    
                //TODO: Either allow Random PartOfSpeech OR implement picker!
                //TODO: These constants should be defined somewhere else
                let pos = PartOfSpeech.verb //PartOfSpeech.allCases.randomElement() ?? PartOfSpeech.noun
                let wordsPerExercise = 7
                let wrongPairs = 3
                
                let words = dict.words
                    .filter { word in word.partOfSpeech == pos && !learnedSet.contains(word.identity)}
                    .shuffled()
                let trainingSet = words.prefix(wordsPerExercise)
                let wrongAnswers = words
                    .dropFirst(wordsPerExercise)
                    .shuffled()
                    .prefix(wrongPairs)
                    .compactMap { $0.translate.first}
                
                return TranslateExerciseViewModel(trainingSet: Array(trainingSet),
                                                  answersDiversity: wrongAnswers,
                                                  exercise: exercise,
                                                  progressService:  ProgressService(dictionary: dict.from))
            })
            .subscribe(onNext: { (translateExercise) in
                
                viewModel.coordinator.transition(to: .translateExercise(translateExercise),
                                                 type: .push)
            })
            .disposed(by: viewModel.rx_disposeBag)
            
        }.asObserver()
    }
}
