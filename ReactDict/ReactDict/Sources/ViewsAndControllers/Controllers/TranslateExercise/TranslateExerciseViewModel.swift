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
    private var isDirectTranslate: Bool {
        return exercice == .directTranslate
    }
    
    let answers = ReplaySubject<String>.create(bufferSize:1)
    var learning = ReplaySubject<String>.create(bufferSize:1)
    var options = ReplaySubject<[String]>.create(bufferSize:1)
    let rx_disposeBag = DisposeBag()
    
    
    init(trainingSet: [Word],
         answersDiversity: [String],
         exercise: Exercise) {
        
        self.words = trainingSet
        self.wrongAnswers = answersDiversity
        self.exercice = exercise
    
        subscribeObservers()
    }
    

    var rxNextWord: AnyObserver<String> {
        
        return Binder(self) { (viewModel, answer) in
            
            viewModel.answers.onNext(answer)
            
            let idx = ((try? viewModel.index.value()) ?? 0) + 1
            if idx < viewModel.words.count {
                viewModel.index.onNext(idx)
            } else {
                viewModel.answers.onCompleted()
                viewModel.index.onCompleted()
            }
        }
        .asObserver()
    }
    
    
    private func subscribeObservers() {
        
        let answersDiversity = self.wrongAnswers
        let isDirectTranslate = self.isDirectTranslate
        
        let source = Observable.zip(Observable.from(words), index.asObservable()).share()
        source.map { (word, index) -> String in
            isDirectTranslate ? word.word : word.translate.randomElement() ?? ""
        }
        .subscribe(learning)
        .disposed(by: rx_disposeBag)
        
        source.map { (word, index) -> [String] in
            //TODO: .prefix(4)) — remove constant. Should be configuration object
            var answerOptions = Array(answersDiversity.shuffled().prefix(4))
            answerOptions.append(isDirectTranslate ? word.translate.randomElement() ?? "" : word.word)
            return answerOptions.shuffled()
        }
        .subscribe(options)
        .disposed(by: rx_disposeBag)
    }
}
