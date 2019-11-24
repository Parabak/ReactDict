//
//  Dictionary.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation


struct Dictionary : Codable {
    
    let words : Array<Word>
    let from: String
    let to: String
    let version: String
    
    
    var count : Int {
        return words.count
    }

    
    func test() {
        
        let t = Set(words)
        
    }
}
