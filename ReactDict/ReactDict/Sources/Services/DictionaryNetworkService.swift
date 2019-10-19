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
    
    private let baseURL = "https://api.myjson.com/bins/15ikvo"
    
    var url : URL {
        return URL(string: baseURL)!
    }
}
