//
//  WordProgressStatusCell.swift
//  ReactDict
//
//  Created by Aliaksandr Baranouski on 08/12/2019.
//  Copyright © 2019 naschekrasche. All rights reserved.
//

import Foundation
import UIKit


class WordProgressStatusCell: UITableViewCell {
    
    @IBOutlet var lblWord: UILabel!
    @IBOutlet var lblTranslates: UILabel!
    @IBOutlet var lblProgress: UILabel!
    
    
    func configureWith(result: TranslateResult) -> Void {
        
        lblWord.text = result.word.word
        lblTranslates.text = result.word.translate.joined(separator: ", ")
        lblProgress.text = "\(result.successfulAnswers) / \(result.exercise.learningRequirement)"
        //TODO: use some StyleBook
        lblProgress.textColor = result.result ? UIColor.green : UIColor.red
    }
}
