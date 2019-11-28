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
            
            let t = viewModel.dictionary.map { (dict) -> [Word] in
                
                let pos = PartOfSpeech.allCases.randomElement() ?? PartOfSpeech.noun
                let wordsPerExercise = 7
                let wrongPairs = 3
                //TODO: at first train all words, but later only these, which are not learned already
                let words = dict.words.filter { $0.partOfSpeech == pos }.shuffled()
                let trainingSet = words.prefix(wordsPerExercise)
                let wrongAnswers = words
                    .dropFirst(wordsPerExercise)
                    .shuffled()
                    .prefix(wrongPairs)
                    .compactMap { $0.translate.first}
                
                return words
            }
            
        }.asObserver()
    }
}
