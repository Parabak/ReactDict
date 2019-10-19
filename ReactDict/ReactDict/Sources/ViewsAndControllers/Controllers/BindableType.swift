//
//  BindableType.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import UIKit
import RxSwift


protocol BindableType {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    
    func bindViewModel()
}


extension BindableType where Self: UIViewController {
    
    mutating func bindViewModel(to model: Self.ViewModelType) {
        
        self.viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
