//
//  ProgressServiceType.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 05/12/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift


protocol ProgressServiceType {
    
    @discardableResult
    func logAttempt(result: Bool, word: Word, exercise: Exercise) -> Observable<Bool>
}
