//
//  Exercises.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 11/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation


enum Exercise : Int, CaseIterable, Codable {
    case directTranslate = 1
    case reversedTranslate = 2
}


extension Exercise {
    
    func nameSuitableFor(dictionary: Dictionary) -> String {
        switch self {
        case .directTranslate:
            return dictionary.from + "->" + dictionary.to
        case .reversedTranslate:
            return dictionary.to + "->" + dictionary.from
        }
    }
}

extension Exercise {
    
    var learningRequirement: Int {
        switch self {
        case .directTranslate:
            return 7
        case .reversedTranslate:
            return 7
        }
    }
}

