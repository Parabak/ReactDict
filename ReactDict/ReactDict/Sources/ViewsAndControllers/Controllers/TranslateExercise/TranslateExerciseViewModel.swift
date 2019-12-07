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
    private let exercice: Exercise
    private let wrongAnswers: [String]
    private let index = BehaviorSubject<Int>(value: 0)
    private let answers =  ReplaySubject<String>.create(bufferSize:1)
    private var isDirectTranslate: Bool {
        return exercice == .directTranslate
    }
    var learning = ReplaySubject<String>.create(bufferSize:1)
    var options =  ReplaySubject<[String]>.create(bufferSize:1)
    let rx_disposeBag = DisposeBag()
    
    
    init(trainingSet: [Word],
         answersDiversity: [String],
         exercise: Exercise,
         progressService: ProgressServiceType) {
        
        self.words = trainingSet
        self.wrongAnswers = answersDiversity
        self.exercice = exercise
    
        subscribeObservers()
        startAnswerValidation(with: progressService)
    }
    
    
    
    //TODO: action handler
    var rxNextWord: AnyObserver<String> {
        
        return Binder(self) { (viewModel, answer) in
            
            viewModel.answers.onNext(answer)
            
            let idx = (try? viewModel.index.value()) ?? 0
            viewModel.index.onNext(idx + 1)
        }
        .asObserver()
    }
    
    
    private func subscribeObservers() {
        
        let answersDiversity = self.wrongAnswers
        let isDirectTranslate = self.isDirectTranslate
        
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
        .subscribe(options)
        .disposed(by: rx_disposeBag)
        
        
        
        
        source.subscribe(onCompleted: {
            print("All words in lesson are completed!")
        }).disposed(by: rx_disposeBag)
    }
    
    
    private func startAnswerValidation(with service: ProgressServiceType) {
        
        let exercise = self.exercice
        
        Observable.zip(Observable.from(words),
                       answers.asObservable())
            .subscribe(onNext: { (word, answer) in
                
                let result: Bool
                switch exercise {
                case .directTranslate:
                    result = word.translate.contains(answer)
                case .reversedTranslate:
                    result = word.word == answer
                }
                //TODO: maybe better just subscribe ProgressServiceType to the sequence?
                service.logAttempt(result: result,
                                   word: word,
                                   exercise: exercise)
                
                // Publish: word, result and count.
            })
            .disposed(by: rx_disposeBag)
    }
}
