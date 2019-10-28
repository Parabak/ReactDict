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
    let exercises : [Exercises]
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



//class WordModel: Object {
//    @objc dynamic var test: Int = 0
//}
