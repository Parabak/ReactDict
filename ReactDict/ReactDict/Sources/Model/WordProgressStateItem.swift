//
//  WordProgressStateItem.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 06/12/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RealmSwift


class WordProgressStateItem: Object {
    
    @objc dynamic private var uuid: String = UUID().uuidString
    @objc dynamic var wordId: String = UUID().uuidString
    @objc dynamic var counter: Int = 0
    
    convenience init(wordId: String, count: Int) {
        
        self.init()
        self.wordId = wordId
        self.counter = count
    }
    
    
    override class func primaryKey() -> String? {
        return "uuid"
    }
}
