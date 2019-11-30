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
    
    init(trainingSet: [Word],
         answersDiversity: [String],
         isDirectTranslate: Bool) {
        
        self.words = trainingSet
        self.wrongAnswers = answersDiversity
        self.isDirectTranslate = isDirectTranslate
    }
}

