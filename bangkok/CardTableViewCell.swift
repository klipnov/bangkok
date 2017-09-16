//
//  CardTableViewCell.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cardTitle: UILabel!
    @IBOutlet weak var cardDescription: UILabel!
    @IBOutlet weak var cardButton: UIButton!
    
    var didTapSurveyButton: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardButton.roundCorners()
    }
    
    
    @IBAction func didTapButton(_ sender: Any) {
        didTapSurveyButton?()
    }
}
