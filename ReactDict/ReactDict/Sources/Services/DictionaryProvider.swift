//
//  DictionaryProvider.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 23/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift


struct DictionaryProvider: DictionaryProviderType {
    
    let networkService: DictionaryNetworkServiceType
    let storageService: StorageServiceType

    let disposeBag = DisposeBag()
    
    
    func loadDictionary() -> Observable<Dictionary> {
        
        //TODO: will be remoteDictionary called on connection error??
        
        let testWord = Word(word: "some", partOfSpeech: .adjective, translate: ["translate"], exercises: [.directTranslate], notes: nil, version: 0)
        return Observable.just(Dictionary(words: [testWord], from: "test", to: "test2", version: "1.0.0"))
        
//        return Observable.combineLatest(storageService.loadDictionary(),
//                                        networkService.loadDictionary())
//            .flatMap({ (localDictionary, remoteDictionary) -> Observable<Dictionary> in
//
//                if let local = localDictionary, let remote = remoteDictionary {
//
//                    if local.version != remote.version {
//                        self.storageService.update(dictionary: local, to: remote)
//                    }
//                    return Observable.of(remote)
//                } else if let remote = remoteDictionary {
//
//                    return Observable
//                        .combineLatest(self.storageService.save(dictionary: remote),
//                                       Observable.of(remote))
//                        .map { _, remote -> Dictionary in
//                            return remote
//                    }
//                } else {
//                    return Observable.empty()
//                }
//            })
    }
}
