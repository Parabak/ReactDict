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
    
    case saveDictionaryFailed
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
            
            realm.delete(dictionary.words)
            
            try realm.write {
                
                dictionary.from = remote.from
                dictionary.to = remote.to
                dictionary.version = remote.version
                dictionary.words = List()
                //TODO: measure performance on 1000 and 3000 items. Maybe it's better to enumerate words and comapre there version
                dictionary.words.append(objectsIn: remote.words.map { WordItem(with: $0)})
            }
            
            return .just(dictionary)
        }
        
        return result ?? .error(StorageServiceError.updateDictionaryFailed(dictionary))
    }
    
    
    func save(dictionary: Dictionary) -> Observable<DictionaryItem> {
        
        let result = withRealm("savingDictionary") { (realm) -> Observable<DictionaryItem> in
            
            let dictinaryItem = DictionaryItem(dictionary: dictionary)
            try realm.write {
                realm.add(dictinaryItem)
            }
            
            return .just(dictinaryItem)
        }
        
        return result ?? .error(StorageServiceError.saveDictionaryFailed)
    }
}

