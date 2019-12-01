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
    
    let progress = PublishSubject<Word>()
    var learning: Observable<String>
    var answers: Observable<[String]>
    
    init(trainingSet: [Word],
         answersDiversity: [String],
         isDirectTranslate: Bool) {
        
        self.words = trainingSet
        self.wrongAnswers = answersDiversity
        self.isDirectTranslate = isDirectTranslate
        
        if let word = words.first {
            progress.onNext(word)
        }
        
        learning = progress.map({ (word) -> String in
            isDirectTranslate ? word.word : word.translate.randomElement() ?? ""
        })
        
        answers = progress.map({ (word) -> [String] in
            var all = Array(answersDiversity.shuffled().prefix(3))
            all.append(isDirectTranslate ? word.translate.randomElement() ?? "" : word.word)
            return all
        })
    }
    
    //TODO: action handler
}

