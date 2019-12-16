//
//  PartOfSpeech.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 28/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation


enum PartOfSpeech : String, Codable, CaseIterable {
    
    case verb
    case noun
    case adjective
    case adverb
    case pronoun
    case conjunction
    case expression
}


extension PartOfSpeech {
    
    static var defaultValue : String { return "all" }
}
