//
//  LessonResultViewController.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 08/12/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources


class LessonResultViewController: UIViewController, BindableType {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel: LessonResultViewModel!
    
    let rx_disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedAnimatedDataSource<ResultSection>(configureCell: configureCell)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        //TODO: right nav bar: Done
    }
    
    func bindViewModel() {
  
        viewModel.sectionedResults
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx_disposeBag)
    }
    
    
    private var configureCell: TableViewSectionedDataSource<ResultSection>.ConfigureCell {
        
        return { section, tableView, indexPath, translateResult -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LessonResultCell") as? WordProgressStatusCell else {
                return UITableViewCell()
            }
            
            cell.configureWith(result: translateResult)
            
            return cell
        }
    }
}
