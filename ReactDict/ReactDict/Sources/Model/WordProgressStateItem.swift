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
    
    @objc dynamic var hashId: Int = 0
    @objc dynamic var counter: Int = 0
    
    convenience init(wordHashId: Int, count: Int) {
        
        self.init()
        hashId = wordHashId
        counter = count
    }
    
    
    override class func primaryKey() -> String? {
        return "hashId"
    }
}
