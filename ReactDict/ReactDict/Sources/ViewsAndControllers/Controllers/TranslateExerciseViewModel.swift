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
       // word has will be save in ProgressManager
    let words: [Word]
    let isDirectTranslate: Bool
    let wrongAnswers: [String]
}

