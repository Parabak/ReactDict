//
//  Exercises.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 11/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation


enum Exercises : Int {
    case directTranslate = 1
    case reversedTranslate = 2
}

extension Exercises : Decodable, Encodable {
    
}

