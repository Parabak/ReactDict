//
//  LanguageViewController.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


class LanguageViewController: UITabBarController, BindableType {
    
    let disposeBag = DisposeBag()
    
    var viewModel: LanguageViewModel!

    func bindViewModel() {
        
        viewModel.dictionary.subscribe(onError: { error in
            //TODO: show warning message. Try create Observer that will trigger on errors
        }).disposed(by: self.disposeBag)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
}
