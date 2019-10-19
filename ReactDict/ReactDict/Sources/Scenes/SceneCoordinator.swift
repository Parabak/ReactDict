//
//  SceneCoordinator.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


class SceneCoordinator: SceneCoordinatorType {
    
    fileprivate let window: UIWindow
    fileprivate var currentViewController: UIViewController?
    
    required init(window: UIWindow) {
        
        self.window = window
        currentViewController = window.rootViewController
    }
    
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void> {
        
        let subject = PublishSubject<Void>()
        let vc = scene.viewController()
        
        switch type {
        case .root:
            
            currentViewController = SceneCoordinator.actualViewController(for: vc)
            window.rootViewController = vc
            subject.onCompleted()
        default:
            break
        }
        
        return subject.asObservable()
            .take(1)
            .filter{false}
    }
    
    
    private static func actualViewController(for viewController: UIViewController) -> UIViewController {
      if let navigationController = viewController as? UINavigationController {
        return navigationController.viewControllers.first!
      } else {
        return viewController
      }
    }
}
