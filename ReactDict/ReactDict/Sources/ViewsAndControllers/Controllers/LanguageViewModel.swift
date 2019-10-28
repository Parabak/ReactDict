//
//  LanguageViewModel.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift


struct LanguageViewModel {
    
    let bag = DisposeBag()
    
    let service: DictionaryNetworkServiceType
    let coordinator: SceneCoordinatorType
    
    var dictionary: Observable<Dictionary> {
        
        let dict = service.loadDictionary()
        
        dict.subscribe(onNext: {dictModel in
            
            let wordsModel = WordsViewModel(words: Observable.of(dictModel.words))
            let scene = Scene.list(wordsModel)
            self.coordinator.transition(to: scene, type: .tabBar)
        })
        .disposed(by: bag)
        
        return dict
    }
}
