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
    
    var url : URL { get }
    
    func loadDictionary() -> Observable<[Word]>
}


extension DictionaryNetworkServiceType {
    
    func loadDictionary() -> Observable<[Word]> {
        
        URLSession.shared.rx
            .json(.get, url)
            .retry(3)
            .flatMap { data -> Observable<[Word]> in
                
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let decoder = JSONDecoder()
                let words = try decoder.decode([Word].self,
                                               from: jsonData)
                return Observable.of(words)
            }
            .subscribeOn(MainScheduler.instance)
    }
}
