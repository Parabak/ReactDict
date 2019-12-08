//
//  TranslateResult.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 08/12/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxDataSources


struct TranslateResult {
    
    let word: Word
    let result: Bool
    let successfulAnswers: Int
    let exercise: Exercise
}


extension TranslateResult: IdentifiableType {
    
    var identity: Int {
        return word.identity
    }
}

extension TranslateResult: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        
        return lhs.word == rhs.word
            && lhs.result == rhs.result
            && lhs.exercise == rhs.exercise
            && lhs.successfulAnswers == rhs.successfulAnswers
    }
}
