//
//  DictionaryItem.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 04/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RealmSwift


class DictionaryItem: Object {
    
    @objc dynamic var words: [WordItem] = [WordItem]()
    @objc dynamic var from: String = ""
    @objc dynamic var to: String = ""
    @objc dynamic var version: String = ""

    
    override class func primaryKey() -> String? {
        return "from"
    }
    
    
    convenience init(dictionary: Dictionary) {
        
        self.init()
        self.words = dictionary.words.map { WordItem(with: $0) }
        self.from = dictionary.from
        self.to = dictionary.to
        self.version = dictionary.version
    }
}
