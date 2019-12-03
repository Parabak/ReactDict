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
    private let events = PublishSubject<Void>()
    
    var viewModel: TranslateExerciseViewModel!
    
    @IBOutlet weak var learningWord: UILabel!
    @IBOutlet weak var answersList: TagListView!
    @IBOutlet weak var actionBtn: UIButton! // next / done
    
    
    func bindViewModel() {

        viewModel.learning
            .subscribe(onNext: { [weak self] word in
                self?.learningWord.text = word
            })
            .disposed(by: rx_disposeBag)
        
        viewModel.options
            .subscribe(onNext: { [weak self] answers in
                self?.answersList.addTags(answers)
            }).disposed(by: rx_disposeBag)
        
//        events.asObservable().bind(to: viewModel.rxNextWord)
        
    }
}


//TODO: as an exercise I can try to write rx extension for TagListViewDelegate
extension TranslateViewController: TagListViewDelegate {
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
//        viewModel.
    }
}
