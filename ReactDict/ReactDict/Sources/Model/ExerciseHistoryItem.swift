//
//  ExerciseHistoryItem.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 06/12/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RealmSwift


class ExerciseHistoryItem: Object {
    
    
    @objc dynamic var dictKey: String = ""
    dynamic var wordProgresses: List<WordProgressStateItem> = List<WordProgressStateItem>()
    @objc dynamic var exerciseRaw: Int = Exercise.directTranslate.rawValue
    
    convenience init(exercise: Exercise, dictionaryKey: String) {
        self.init()
        self.exerciseRaw = exercise.rawValue
    }
    
    
    override class func primaryKey() -> String? {
        return "exerciseRaw"
    }
    
    
    func updateAndReturnCounterFor(wordHash: Int, by: Int) -> Int {
        
        var counter = 0
        let copies = wordProgresses.filter{$0.hashId == wordHash}
        if let word = copies.first {
            word.counter = max(0, word.counter + by)
            counter = word.counter
        } else {
            let word = WordProgressStateItem(wordHashId: wordHash, count: max(0, by))
            wordProgresses.append(word)
            counter = word.counter
        }

        return counter
    }
}
