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
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var didTapSurveyButton: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.roundCorners()
    }
    
    
    @IBAction func didTapButton(_ sender: Any) {
        didTapSurveyButton?()
    }
}
