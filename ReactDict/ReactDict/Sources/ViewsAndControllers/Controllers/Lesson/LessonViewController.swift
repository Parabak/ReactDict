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
    @IBOutlet weak var posPicker: UIPickerView!
    
    
    func bindViewModel() {
                        
        viewModel.excercises
            .subscribe(onNext: { [weak self] option in
                
                guard let self = self else { return }
                               
                let btn = UIButton.makeBtn(forExercise: option.title)
                self.startExerciseBtnsStack.addArrangedSubview(btn)
                
                let selectedPOS = self.posPicker.rx.modelSelected(String.self).startWith([PartOfSpeech.defaultValue])
                btn.rx.tap.withLatestFrom(selectedPOS)
                    .map {
                        LessonViewModel.ExerciseParam(option.type,
                                                      PartOfSpeech(rawValue: $0.first?.lowercased() ?? ""))
                    }
                    .bind(to: self.viewModel.rxStartExercise)
                    .disposed(by: self.rx_disposeBag)
            })
            .disposed(by: rx_disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillPOSPicker()
        NSLayoutConstraint.activate(addExerciseStartBtns())
    }
    
    
    private func addExerciseStartBtns() -> [NSLayoutConstraint] {
    
        startExerciseBtnsStack.translatesAutoresizingMaskIntoConstraints = false
        startExerciseBtnsStack.axis = .vertical
        startExerciseBtnsStack.alignment = .center
        startExerciseBtnsStack.spacing = 20
        
        return [startExerciseBtnsStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                startExerciseBtnsStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                startExerciseBtnsStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                startExerciseBtnsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
    }
    
    
    private func fillPOSPicker() -> Void {
        
        let data = ["All"] + PartOfSpeech.allCases.filter{ $0 != .expression }.map {$0.rawValue.uppercased()}
        Observable.of(data)
            .bind(to: posPicker.rx.itemTitles)  { (row, title) -> String? in
                return title
            }
            .disposed(by: rx_disposeBag)
    }
}


fileprivate extension UIButton {
    
    static func makeBtn(forExercise exercise: String) -> UIButton {
        
        let btn = UIButton(type: .custom)
        btn.setTitle(exercise, for: .normal)
        btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        btn.setTitleColor(.black, for: .normal)
        
        return btn
    }
}
