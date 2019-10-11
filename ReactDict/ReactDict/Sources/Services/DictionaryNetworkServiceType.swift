//
//  DictionaryNetworkServiceType.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 11/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift


protocol DictionaryNetworkServiceType {
    
    func loadDictionary() -> Observable<[Word]>
}
