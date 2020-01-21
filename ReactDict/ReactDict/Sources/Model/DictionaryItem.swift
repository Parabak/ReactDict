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
    
    var words = List<WordItem>()
    @objc dynamic var from: String = ""
    @objc dynamic var to: String = ""
    @objc dynamic var version: String = ""

    //TODO: Primary key can't be changed and also primary key from will be not unique if we add CZ -> ENG; CZ -> IT
    override class func primaryKey() -> String? {
        return "from"
    }
    
    
    convenience init(dictionary: Dictionary) {
        
        self.init()
        self.words = List()
        self.words.append(objectsIn: dictionary.words.map { WordItem(with: $0) })
        self.from = dictionary.from
        self.to = dictionary.to
        self.version = dictionary.version
    }
}
