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
    
    let service: DictionaryProviderType
    let coordinator: SceneCoordinatorType
    
    var dictionary: Observable<Dictionary> {
        
        let dict = service.loadDictionary()
        
        dict.subscribe(onNext: {dictModel in
            
            let wordsModel = WordsViewModel(words: Observable.of(dictModel.words))
            let scene = Scene.list(wordsModel)
            self.coordinator.transition(to: scene, type: .tabBar)
            
            let lessonViewModel = LessonViewModel(dictionary: Observable.just(dictModel),
                                                  coordinator: self.coordinator)
            let sceneLesson = Scene.lesson(lessonViewModel)
            self.coordinator.transition(to: sceneLesson, type: .tabBar)
            
        }, onError: { error in
            //TODO: self.coordinator.transition(to: "error", type: .popup])
        })
        .disposed(by: bag)
        
        return dict
    }
}
