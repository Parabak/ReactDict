//
//  StorageService.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 04/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift


protocol StorageServiceType {
    
    @discardableResult
    func loadDictionary() -> Observable<DictionaryItem?>
    
    @discardableResult
    func update(dictionary: DictionaryItem, to: Dictionary) -> Observable<DictionaryItem>
    
    @discardableResult
    func save(dictionary: Dictionary) -> Observable<DictionaryItem>
}
