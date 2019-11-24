//
//  StorageService.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 04/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


enum StorageServiceError: Error {
    
    case updateDictionaryFailed(DictionaryItem)
}


struct StorageService: StorageServiceType {

    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        
        do {
            
            let realm = try Realm()
            return try action(realm)
        } catch let error  {
            
            print("Failed \(operation) realm with error: \(error)")
            return nil
        }
    }
    
    
    @discardableResult
    func loadDictionary() -> Observable<DictionaryItem?> {
        
        let result = withRealm("ReadingDictionary") { (realm) -> Observable<DictionaryItem?> in
            
            let dictionary = realm.objects(DictionaryItem.self)
            
            return .just(dictionary.first)
        }
        
        return result ?? Observable.empty()
    }
    
    
    func update(dictionary: DictionaryItem,
                to remote: Dictionary) -> Observable<DictionaryItem> {
        
        let result = withRealm("updatingDictionary") { (realm) -> Observable<DictionaryItem> in
            
            try realm.write {
                
                dictionary.from = remote.from
                dictionary.to = remote.to
                dictionary.version = remote.version
            }
            
            return .just(dictionary)
        }
//        return result ?? .err
        
        assertionFailure("not implemented yet")
        return .never()
    }
    
    
    func save(dictionary: Dictionary) -> Observable<DictionaryItem> {
        assertionFailure("not implemented yet")
        return .never()
    }
}

