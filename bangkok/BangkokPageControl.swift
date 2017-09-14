//
//  BangkokPageControl.swift
//  bangkok
//
//  Created by Shah Qays on 15/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class BangkokPageControl: UIPageControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPageControl()
    }
    
    func setupPageControl() {
        let angle = CGFloat(Double.pi/2)
        self.transform = CGAffineTransform(rotationAngle: angle)
    }

}
