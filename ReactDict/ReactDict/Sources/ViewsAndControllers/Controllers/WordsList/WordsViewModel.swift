//
//  WordsViewModel.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 18/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources


typealias CategorySection = AnimatableSectionModel<String, Word>

struct WordsViewModel  {

    let rx_disposeBag = DisposeBag()
    
    var sectionedItems: Observable<[CategorySection]>
    
    
    init(words: Observable<[Word]>) {
        
        sectionedItems = words.map { words -> [CategorySection] in
            
            var sections = [CategorySection]()
            for partOfSpeech in PartOfSpeech.allCases {
                
                let section = CategorySection(model: partOfSpeech.rawValue,
                                              items: words.filter { $0.partOfSpeech == partOfSpeech })
                sections.append(section)
            }
            
            return sections
        }.debug()
    }
}


