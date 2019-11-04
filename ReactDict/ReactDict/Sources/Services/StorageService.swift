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


struct StorageService: StorageServiceType {
    
    
    func loadDictionary() -> Observable<DictionaryItem> {
        
        return Observable.never()
    }
}

