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
    
    func loadDictionary() -> Observable<Dictionary?>
}


extension DictionaryNetworkServiceType {
    
    func loadDictionary() -> Observable<Dictionary?> {
                    
        let publisher = PublishSubject<Dictionary?>()
        
        let request = URLSession.shared.rx
        .json(.get, url)
        .retry(3)
        .catchError { (error) -> Observable<Any> in
            print("Error happened: \(error.localizedDescription)")
            return .empty()
        }
        .flatMap { data -> Observable<Dictionary> in
            
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            let decoder = JSONDecoder()
            let dictionary = try decoder.decode(Dictionary.self,
                                                from: jsonData)
            return Observable.of(dictionary)
        }
        
        request.subscribe(onNext: { (dict) in
            publisher.onNext(dict)
        }, onCompleted: {
            publisher.onNext(nil)
        }).disposed(by: disposeBag)
        
        return publisher.asObservable()
    }
}
