//
//  ExerciseViewModel.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 28/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class TranslateExerciseViewModel {
    
    private let words: [Word]
    private let isDirectTranslate: Bool
    private let wrongAnswers: [String]
    
    let rx_disposeBag = DisposeBag()
    
//    private let progress = PublishSubject<Word>()
    
    private let index = BehaviorSubject<Int>(value: 0)
    
    var learning = ReplaySubject<String>.create(bufferSize:1)
    var answers =  ReplaySubject<[String]>.create(bufferSize:1)
        
    init(trainingSet: [Word],
         answersDiversity: [String],
         isDirectTranslate: Bool) {
        
        self.words = trainingSet
        self.wrongAnswers = answersDiversity
        self.isDirectTranslate = isDirectTranslate
        
//        progress
//            .map({ (word) -> String in
//            isDirectTranslate ? word.word : word.translate.randomElement() ?? ""
//            })
//            .subscribe(learning)
//            .disposed(by: rx_disposeBag)
//
//        progress
//            .map({ (word) -> [String] in
//                var all = Array(answersDiversity.shuffled().prefix(3))
//                all.append(isDirectTranslate ? word.translate.randomElement() ?? "" : word.word)
//                return all
//            })
//            .subscribe(answers)
//            .disposed(by: rx_disposeBag)
//
//
//        if let word = words.first {
//            progress.onNext(word)
//        }
        
        // Testing block
        let source = Observable.zip(Observable.from(words),
                                    index.asObservable())
        source.map { (word, index) -> String in
            isDirectTranslate ? word.word : word.translate.randomElement() ?? ""
        }
        .subscribe(learning)
        .disposed(by: rx_disposeBag)
        
        source.map { (word, index) -> [String] in
            var answerOptions = Array(answersDiversity.shuffled().prefix(3))
            answerOptions.append(isDirectTranslate ? word.translate.randomElement() ?? "" : word.word)
            return answerOptions
        }
        .subscribe(answers)
        .disposed(by: rx_disposeBag)
    }

    
    //TODO: action handler
    var rxNextWord: AnyObserver<Void> {
        
        return Binder(self) { (viewModel, idx) in

            //How to validate result?!
            
            let idx = (try? viewModel.index.value()) ?? 0
            viewModel.index.onNext(idx + 1)
        }
        .asObserver()
    }
}
