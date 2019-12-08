//
//  Word.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 11/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxDataSources
import RealmSwift


struct Word : Codable {
    
    let word : String
    let partOfSpeech: PartOfSpeech
    let translate : [String]
    let exercises : [Exercise]
    let notes: String?
    let version: Int
}


extension Word {
    
    init(item: WordItem) {
                
        self.init(word: item.word,
                  partOfSpeech: PartOfSpeech(rawValue: item.partOfSpeech) ?? PartOfSpeech.noun,
                  translate: Array(item.translate),
                  exercises: item.exercises.compactMap { Exercise(rawValue: $0)},
                  notes: item.notes,
                  version: item.version)
    }
}


extension Word: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        
        return lhs.word == rhs.word && Set(lhs.translate) == Set(rhs.translate) && Set(lhs.exercises) == Set(rhs.exercises)
    }
}


//TODO: Later on Identifiable should be Model loaded from DB
//TODO: maybe use better hash function
extension Word: IdentifiableType {
    
    var identity: Int {
        return word.hashValue
    }
}


extension Word: Hashable {
    
    func hash(into hasher: inout Hasher) {
        //TODO: Hash should return the same result between session. I have to generate GUID
        hasher.combine(word)
    }
}


extension Word {
    
    static func makeNullObject() -> Word {        
        return Word(word: "", partOfSpeech: .adjective, translate: [""], exercises: [.directTranslate], notes: nil, version: 0)
    }
}
