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
    var disposeBag : DisposeBag { get }
    
    func loadDictionary() -> Observable<Dictionary>
}


extension DictionaryNetworkServiceType {
    
    func loadDictionary() -> Observable<Dictionary> {
             
        return URLSession.shared.rx
        .json(.get, url)
        .retry(3)
        .flatMap { data -> Observable<Dictionary> in
            
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            let decoder = JSONDecoder()
            let dictionary = try decoder.decode(Dictionary.self,
                                                from: jsonData)
            return Observable.of(dictionary)
        }.observeOn(MainScheduler.instance)
    }
}
