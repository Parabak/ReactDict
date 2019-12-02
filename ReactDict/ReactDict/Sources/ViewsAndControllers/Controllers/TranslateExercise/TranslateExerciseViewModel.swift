//
//  ExerciseViewModel.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 28/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift


struct TranslateExerciseViewModel {
    
    private let words: [Word]
    private let isDirectTranslate: Bool
    private let wrongAnswers: [String]
    
    let rx_disposeBag = DisposeBag()
    
    private let progress = PublishSubject<Word>()
    var learning = ReplaySubject<String>.create(bufferSize:1)
    var answers =  ReplaySubject<[String]>.create(bufferSize:1)
        
    init(trainingSet: [Word],
         answersDiversity: [String],
         isDirectTranslate: Bool) {
        
        self.words = trainingSet
        self.wrongAnswers = answersDiversity
        self.isDirectTranslate = isDirectTranslate
        
        progress
            .map({ (word) -> String in
            isDirectTranslate ? word.word : word.translate.randomElement() ?? ""
            })
            .subscribe(learning)
            .disposed(by: rx_disposeBag)
        
        progress
            .map({ (word) -> [String] in
                var all = Array(answersDiversity.shuffled().prefix(3))
                all.append(isDirectTranslate ? word.translate.randomElement() ?? "" : word.word)
                return all
            })
            .subscribe(answers)
            .disposed(by: rx_disposeBag)
            
        if let word = words.first {
            progress.onNext(word)
        }
    }
    
    //TODO: action handler
}

