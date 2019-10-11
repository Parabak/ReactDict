//
//  Word.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 11/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation


struct Word : Codable {
    
    let word : String
    let translate : [String]
    let exercises : [Exercises]
    
//    enum CodingKeys: String, CodingKey {
//        case langKey =
//    }
    /**
     //Custom Keys
     enum CodingKeys: String, CodingKey {
         case userId
         case id = "serviceId"  //Custom keys
         case title = "titleKey" //Custom keys
         case completed
     }
     */
}


extension Word : Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.word == rhs.word && Set(lhs.translate) == Set(rhs.translate) && Set(lhs.exercises) == Set(rhs.exercises)
    }
}
