//
//  ExcercisesViewController.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


class TranslateViewController: UIViewController, BindableType {
    
    private let rx_disposeBag = DisposeBag()
    
    var viewModel: TranslateExerciseViewModel!
    
    @IBOutlet weak var learningWord: UILabel!
    @IBOutlet weak var answersList: TagListView!
    
    func bindViewModel() {
    
//        viewModel.test
//            .subscribe(onNext: { [weak self] word in
//                self?.learningWord.text = word
//            })
//            .disposed(by: rx_disposeBag)
//
        viewModel.learning
            .subscribe(onNext: { [weak self] word in
                self?.learningWord.text = word
            })
            .disposed(by: rx_disposeBag)
        
        viewModel.answers
            .subscribe(onNext: { [weak self] answers in
                self?.answersList.addTags(answers)
            }).disposed(by: rx_disposeBag)
    }
}
