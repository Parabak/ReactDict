//
//  WordsViewController.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 19/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources


class WordsViewController: UIViewController, BindableType {
    
    @IBOutlet var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var viewModel: WordsViewModel!
    
    private let rx_disposeBag = DisposeBag()
    private lazy var dataSource = RxTableViewSectionedAnimatedDataSource<CategorySection>(configureCell: configureCell,
                                                                                     titleForHeaderInSection: configureHeader)
    
    
    func bindViewModel() {

        viewModel.sectionedItems
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx_disposeBag)
    }
    
    
    private var configureCell: TableViewSectionedDataSource<CategorySection>.ConfigureCell {
        
        return { section, tableView, indexPath, word -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordItemCell", for: indexPath) as? WordTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: word)
            
            return cell
        }
    }
    
    
    private var configureHeader: TableViewSectionedDataSource<CategorySection>.TitleForHeaderInSection {
        
        return { dataSource, idx -> String in
            return dataSource[idx].model.capitalized
        }
    }
}
