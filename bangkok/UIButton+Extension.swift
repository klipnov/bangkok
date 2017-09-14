//
//  UIButton+Extension.swift
//  bangkok
//
//  Created by Shah Qays on 15/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

extension UIButton {
    
    func roundCorners() {
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
    }
    
}
