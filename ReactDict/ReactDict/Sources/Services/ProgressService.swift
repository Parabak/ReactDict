//
//  ProgressService.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 05/12/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


struct ProgressService: ProgressServiceType {
    
    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {

        do {

            let realm = try Realm()
            return try action(realm)
        } catch let error  {

            print("Failed \(operation) realm with error: \(error)")
            return nil
        }
    }
    
        
    func logAttempt(result: Bool, word: Word, exercise: Exercise) -> Observable<Bool> {
        
        if let result = withRealm("SaveExerciseResult", action: { realm -> Observable<Bool> in
            
//            realm
        })
        
        return result ?? .just(false)
    }
}

class WordLearningStateItem: Object {
    
    let hashId: Int
    let counter: Int
    
    override class func primaryKey() -> String? {
        return "hashId"
    }
}

class ExerciseHistoryItem: Object {
    
    let exercise: Exercise
    private exerciseRaw: Int
    let words: List<WordLearningStateItem>
    
    override class func primaryKey() -> String? {
        return "exerciseRaw"
    }
}
