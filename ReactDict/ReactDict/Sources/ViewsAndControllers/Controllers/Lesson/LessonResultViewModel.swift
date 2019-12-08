//
//  LessonResultViewModel.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 08/12/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources


typealias ResultSection = AnimatableSectionModel<String, TranslateResult>

struct LessonResultViewModel {
    
    let sectionedResults: Observable<[ResultSection]>

    let rx_disposeBag = DisposeBag()
    
    init(results: [TranslateResult]) {
        
        let section = ResultSection(model: "", items: results)        
        sectionedResults = Observable.of([section])
    }
}
