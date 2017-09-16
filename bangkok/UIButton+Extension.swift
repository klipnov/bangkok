//
//  UIButton+Extension.swift
//  bangkok
//
//  Created by Shah Qays on 15/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
     
     Rounds the corners of a button
     
     */
    
    func roundCorners() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
}
