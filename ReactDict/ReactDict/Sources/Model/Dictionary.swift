//
//  Dictionary.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift


struct Dictionary : Codable {
    
    let words : Array<Word>
    let from: String
    let to: String
    let version: String
    
    var count : Int {
        return words.count
    }
}

extension Dictionary {
    
    init(dictionaryItem: DictionaryItem) {
        
        self.from = dictionaryItem.from
        self.to = dictionaryItem.to
        self.version = dictionaryItem.version
        self.words = dictionaryItem.words.map { Word(item: $0) }
    }
}


extension Dictionary: EventConvertible {
    var event: Event<Dictionary> {
        return .next(self)
    }
    
    typealias Element = Dictionary
}
