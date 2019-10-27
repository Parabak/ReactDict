//
//  Scene+ViewController.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit


extension Scene {
    
    func viewController() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch self {
        case .language(let languageModel):
            
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Language") as? LanguageViewController else {
                return UIViewController()
            }
            var viewController = vc
            viewController.bind(viewModel: languageModel)
            return viewController
        case .list(let wordsModel):
            
            guard let vc = storyboard.instantiateViewController(withIdentifier: "Words") as? WordsViewController else {
                return UIViewController()
            }
            var viewController = vc
            viewController.bind(viewModel: wordsModel)
            return viewController
//        case .excercises
        default:
            return UIViewController()
        }
    }
}
