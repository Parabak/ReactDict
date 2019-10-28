//
//  WordTableViewCell.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 28/10/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class WordTableViewCell: UITableViewCell {
    
    @IBOutlet var lblPrimary: UILabel!
    @IBOutlet var lblTranslation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        //TODO: use some StyleBook
        lblPrimary.font = UIFont.systemFont(ofSize: 15, weight: .light)
        lblPrimary.textColor = UIColor.darkText
        lblTranslation.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        lblTranslation.textColor = UIColor.darkText
    }
    
    
    func configure(with word: Word) {
        
        lblPrimary.text = word.word
        lblTranslation.text = word.translate.joined(separator: ",")
    }
}
