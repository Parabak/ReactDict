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
    
    let dictionary: String
    
    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {

        do {

            let realm = try Realm()
            return try action(realm)
        } catch let error  {

            print("Failed \(operation) realm with error: \(error)")
            return nil
        }
    }
    
    
    func completedWordsFor(exercise: Exercise) -> Observable<Set<String>> {
        
        let dictionaryKey = dictionary
        let result = withRealm("ReadingExerciseHistory") { (realm) -> Observable<Set<String>> in
            
            let items = realm.objects(ExerciseHistoryItem.self).filter { $0.exerciseRaw == exercise.rawValue && $0.dictKey == dictionaryKey}
            guard let history = items.first else { return Observable.just([]) }
            
            let learnedWordsIds = history.wordProgresses
                .filter { $0.counter == exercise.learningRequirement }
                .map { $0.wordId }

            return Observable.just(Set(learnedWordsIds))
        }
        
        return result ?? Observable.just([])
    }
    

    func logAttempt(result: Bool, word: Word, exercise: Exercise) -> Observable<Int> {
        
        let dictionaryKey = dictionary
        
        let result = withRealm("SaveExerciseResult", action: { realm -> Observable<Int> in
         
            let items = realm.objects(ExerciseHistoryItem.self).filter { $0.exerciseRaw == exercise.rawValue && $0.dictKey == dictionaryKey}
            let history = items.first ?? ExerciseHistoryItem(exercise: exercise, dictionaryKey: dictionaryKey)                
            var wordCounter = 0
            
            try realm.write {
                
                wordCounter = history.updateAndReturnCounterFor(wordId: word.uuid,
                                                                    by: result ? 1 : -1)
                realm.add(history)
            }
            
            return .just(wordCounter)
        })
        
        return result ?? .just(0)
    }
}
