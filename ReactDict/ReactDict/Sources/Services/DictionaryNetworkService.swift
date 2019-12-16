//
//  DictionaryNetworkService.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 11/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire


struct DictionaryNetworkService : DictionaryNetworkServiceType {
    
    private let baseURL = "https://dl.dropboxusercontent.com/s/ec95r8zaanu479l/cz-ru.json?dl=0"
    
    var url : URL {
        return URL(string: baseURL)!
    }
    
    var disposeBag: DisposeBag = DisposeBag()
}
