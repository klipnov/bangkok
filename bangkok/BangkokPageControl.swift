//
//  BangkokPageControl.swift
//  bangkok
//
//  Created by Shah Qays on 15/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class BangkokPageControl: UIPageControl {
    let currentCircle: UIImage = #imageLiteral(resourceName: "dotInsideCircle")
    let otherCircles: UIImage = #imageLiteral(resourceName: "circle")
    
    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPageControl()
    }
    
    func setupPageControl() {
        self.pageIndicatorTintColor = UIColor.clear
        self.currentPageIndicatorTintColor = UIColor.clear
        self.clipsToBounds = false
        
        let angle = CGFloat(Double.pi/2)
        self.transform = CGAffineTransform(rotationAngle: angle)
    }

    
    func updateDots() {
        var i = 0
        for (index,view) in self.subviews.enumerated() {
            var imageView = self.imageView(forSubview: view)
            if imageView == nil {
                if i == 0 {
                    imageView = UIImageView(image: currentCircle)
                } else {
                    imageView = UIImageView(image: otherCircles)
                }
                imageView!.center = view.center
                
                let frame = imageView!.frame
                
                imageView!.frame = CGRect(x: CGFloat(Int(frame.origin.x) + (10 * index)),
                                          y: frame.origin.y,
                                          width: frame.width, height: frame.height)
                view.addSubview(imageView!)
                view.clipsToBounds = false
            }
            if i == self.currentPage {
                imageView!.alpha = 1.0
            } else {
                imageView!.alpha = 1.0
            }
            i += 1
        }
    }
    
    fileprivate func imageView(forSubview view: UIView) -> UIImageView? {
        var dot: UIImageView?
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        return dot
    }

}
