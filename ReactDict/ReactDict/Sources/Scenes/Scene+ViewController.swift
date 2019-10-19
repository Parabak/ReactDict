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
        case .language(let viewModel):
            
            var vc = storyboard.instantiateViewController(withIdentifier: "Language") as! LanguageViewController
            vc.bindViewModel(to: viewModel)
            return vc
//        case .list
//        case .excercises
        default:
            return UIViewController()
        }
    }
}
