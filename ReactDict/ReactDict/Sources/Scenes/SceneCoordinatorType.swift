//
//  SceneCoordinatorType.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 18/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


protocol SceneCoordinatorType {
 
    init(window: UIWindow)
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void>
}
