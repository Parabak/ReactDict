//
//  DictionaryProvider.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 23/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift


protocol DictionaryProviderType {
    
    func loadDictionary() -> Observable<Dictionary>
}
