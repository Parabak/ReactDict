//
//  WordsViewController.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


class WordsViewController: UIViewController, BindableType {
    
    let disposeBag = DisposeBag()
    var viewModel: WordsViewModel!
    
    
    func bindViewModel() {
        
        viewModel.words.subscribe(onNext: { words in            
            print(words)
        }).disposed(by: disposeBag)
    }
}
