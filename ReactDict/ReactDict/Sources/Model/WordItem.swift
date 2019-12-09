//
//  WordItem.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 04/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RealmSwift


class WordItem: Object {
    
    @objc dynamic var word: String = ""
    @objc dynamic var hashId: Int = 0
    @objc dynamic var partOfSpeech: String = ""
    dynamic var translate = List<String>()
    dynamic var exercises = List<Int>()
    @objc dynamic var notes: String? = nil
    @objc dynamic var version: Int = 0
    @objc dynamic var uuid: String = UUID().uuidString
    
    override class func primaryKey() -> String? {
        return "uuid"
    }

    convenience init(with word: Word) {

        self.init()
        self.word = word.word
        self.hashId = word.word.hashValue
        self.partOfSpeech = word.partOfSpeech.rawValue
        self.translate = List<String>()
        self.translate.append(objectsIn: word.translate)
        self.exercises = List<Int>()
        self.exercises.append(objectsIn: word.exercises.map {$0.rawValue})        
        self.notes = word.notes
        self.version = word.version
        self.uuid = word.uuid
    }
}

