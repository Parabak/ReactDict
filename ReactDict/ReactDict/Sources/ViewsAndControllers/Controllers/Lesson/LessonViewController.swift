//
//  LessonController.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 28/11/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class LessonViewController : UIViewController, BindableType {
    
    var viewModel: LessonViewModel!
        
    private let rx_disposeBag = DisposeBag()
    
    @IBOutlet weak var startExerciseBtnsStack: UIStackView!
    
    
    func bindViewModel() {
        
        viewModel.excercises
            .subscribe(onNext: { [weak self] option in
                
                guard let self = self else { return }
                
                let btn = UIButton.makeBtn(forExercise: option.title)
                self.startExerciseBtnsStack.addArrangedSubview(btn)
                btn.rx.tap
                    .map { option.type }
                    .bind(to: self.viewModel.rxStartExercise)
                    .disposed(by: self.rx_disposeBag)
            })
            .disposed(by: rx_disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLayoutConstraint.activate(addExerciseStartBtns())
    }
    
    
    private func addExerciseStartBtns() -> [NSLayoutConstraint] {
    
        startExerciseBtnsStack.translatesAutoresizingMaskIntoConstraints = false
        startExerciseBtnsStack.axis = .vertical
        startExerciseBtnsStack.alignment = .center
        startExerciseBtnsStack.spacing = 5
        
        return [startExerciseBtnsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                startExerciseBtnsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
                startExerciseBtnsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                startExerciseBtnsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
    }
}


fileprivate extension UIButton {
    
    static func makeBtn(forExercise exercise: String) -> UIButton {
        
        let btn = UIButton(type: .custom)
        btn.setTitle(exercise, for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        return btn
    }
}
