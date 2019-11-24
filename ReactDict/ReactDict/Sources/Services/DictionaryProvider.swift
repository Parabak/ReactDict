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
        
        return Observable.combineLatest(storageService.loadDictionary(),
                                        networkService.loadDictionary())
            .flatMap({ (localDictionary, remoteDictionary) -> Observable<Dictionary> in
                
                if let local = localDictionary, let remote = remoteDictionary {
                    
                    if local.version != remote.version {
                        // update local storage
                    }
                    
                    
                    // change Dictionary.words from Array to Set. So I can find quickly word by worditem.hashId
                    // enumerate words and update each one if version is also mismatch.
                    return Observable.of(remote)
                } else if let remote = remoteDictionary {
                    // save remote to local storage
                    return Observable.of(remote)
                } else {
                    return Observable.empty()
                }
            })
    }
}
