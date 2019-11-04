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
    @objc dynamic var translate: [String] = [String]()
    @objc dynamic var exercises: [Int] = [Int]()
    @objc dynamic var notes: String? = nil
    @objc dynamic var version: Int = 0

    override class func primaryKey() -> String? {
        return "hashId"
    }

    convenience init(with word: Word) {

        self.init()
        self.word = word.word
        self.hashId = word.word.hashValue
        self.partOfSpeech = word.partOfSpeech.rawValue
        self.translate = word.translate
        self.exercises = word.exercises.map {$0.rawValue}
        self.notes = word.notes
        self.version = word.version
    }
}





