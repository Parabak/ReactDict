//
//  DictionaryNetworkServiceType.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 11/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt


protocol DictionaryNetworkServiceType {
    
    var url : URL { get }
    var disposeBag : DisposeBag { get }
    
    func loadDictionary() -> Observable<Dictionary?>
}


extension DictionaryNetworkServiceType {
    
    func loadDictionary() -> Observable<Dictionary?> {
                
        typealias JSON = [AnyHashable:Any]
        
        let request = URLSession.shared.rx
            .json(.get, url)
            .retry(3)
            .catchErrorJustReturn(JSON())
            .map { $0 as? JSON ?? JSON() }
            .flatMap { data -> Observable<Dictionary> in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decoder = JSONDecoder()
                    let dictionary = try decoder.decode(Dictionary.self,
                                                        from: jsonData)
                    return Observable.of(dictionary)
                }catch {
                    throw error
                }
            }.materialize()
            .share(replay: 1)

        request.errors().subscribe { (error) in
            print(error.event.debugDescription)
        }.disposed(by: disposeBag)

        return Observable
            .merge(request.elements().flatMap { Observable.just($0) },
                   request.errors().flatMap { _ in Observable.just(nil) })
            .observeOn(MainScheduler.instance)
    }
}
