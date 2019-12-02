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
    
    private let rx_disposeBag = DisposeBag()
    
    
    required init(window: UIWindow) {
        
        self.window = window
        currentViewController = window.rootViewController
    }
    
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void> {
        
        let subject = PublishSubject<Void>()
        //TODO: Point to improve, passing through Subject has code smell
        let sceneController = scene.viewController(transition: subject)
        
        switch type {
        case .root:
            
            currentViewController = SceneCoordinator.actualViewController(for: sceneController)
            window.rootViewController = sceneController
            window.addSubview(sceneController.view)
            subject.onCompleted()
            
            if let tabController = currentViewController as? UITabBarController {
                
                tabController.rx.delegate
                    .sentMessage(#selector(UITabBarControllerDelegate.tabBarController(_:didSelect:)))
                    .subscribe(onNext: { [weak self] _ in
                        self?.currentViewController = tabController.selectedViewController
                    }).disposed(by: rx_disposeBag)
            }
            
        case .tabBar:
        
            if let tabController = findTabController() {
                
                var controllers = tabController.viewControllers ?? [UIViewController]()
                controllers.append(sceneController)
                tabController.setViewControllers(controllers, animated: false)
                subject.onCompleted()
                
                currentViewController = tabController.selectedViewController
            } else {
                
                assertionFailure("can't find UITabController")
            }
            
        case .push:
            
            if let navController = findNavControllerInStack() {
                               
                let disposable = navController.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .subscribe(onNext: { (_) in
                        subject.onCompleted()
                    })
                subject.subscribe(onCompleted: {
                    disposable.dispose()
                }).disposed(by: rx_disposeBag)
                navController.pushViewController(sceneController, animated: true)
            }
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
    
    
    private func findNavControllerInStack() -> UINavigationController? {

        return currentViewController as? UINavigationController ?? currentViewController?.navigationController
    }
    
    
    private func findTabController() -> UITabBarController? {
        
        return currentViewController as? UITabBarController ?? currentViewController?.tabBarController
    }
}
