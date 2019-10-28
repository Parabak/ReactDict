//
//  Scene+ViewController.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


extension Scene {
    
    func viewController(transition: PublishSubject<Void>) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch self {
        case .language(let languageModel):
            
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Language") as? LanguageViewController else {
                return UIViewController()
            }
            var viewController = vc
            
            transition.subscribe(onCompleted: {
                viewController.bind(viewModel: languageModel)
            })
                .disposed(by: languageModel.bag)
            
            return viewController
        case .list(let wordsModel):
            
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Words") as? WordsViewController else {
                return UIViewController()
            }
            var viewController = vc
            
            viewController.tabBarItem = UITabBarItem(title: "Words",
                                                     image: UIImage(systemName: "list.bullet"),
                                                     selectedImage: nil)
            
            transition.subscribe(onCompleted: {
                viewController.bind(viewModel: wordsModel)
            }).disposed(by: wordsModel.rx_disposeBag)
            
            return viewController
//        case .excercises
        default:
            return UIViewController()
        }
    }
}
