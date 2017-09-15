//
//  BangkokPageControl.swift
//  bangkok
//
//  Created by Shah Qays on 15/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class BangkokPageControl: UIPageControl {
    
    let activeImage:UIImage = #imageLiteral(resourceName: "dotInsideCircle")
    let inactiveImage:UIImage = #imageLiteral(resourceName: "circle")
    
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

    override func awakeFromNib() {
        super.awakeFromNib()
        self.pageIndicatorTintColor = UIColor.clear
        self.currentPageIndicatorTintColor = UIColor.clear
        self.clipsToBounds = false
        
        let angle = CGFloat(Double.pi/2)
        self.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    /**
     Updates the subviews of pageControl and changes it to a UIImageView
     */
    func updateDots() {
        var i = 0
        for (index,view) in self.subviews.enumerated() {
            if let imageView = self.imageForSubview(view) {
                if i == self.currentPage {
                    imageView.image = self.activeImage
                } else {
                    imageView.image = self.inactiveImage
                }
                i = i + 1
            } else {
                var dotImage = self.inactiveImage
                if i == self.currentPage {
                    dotImage = self.activeImage
                }
                view.clipsToBounds = false
                let imageView = UIImageView(image: dotImage)
                view.addSubview(imageView)
                distanceViews(index: index, view:imageView)
                i = i + 1
            }
        }
    }
    
    /**
     Moves PageControl dots further apart
     */
    func distanceViews(index:Int ,view: UIView) {
            let frame = view.frame
        
            view.frame = CGRect(
                x: CGFloat(Int(frame.origin.x) + (10 * index)),
                y: frame.origin.y,
                width: frame.width,
                height: frame.height)
    }
    
    /**
     Finds UIImageView in PageControl subviews
    */
    fileprivate func imageForSubview(_ view:UIView) -> UIImageView? {
        var dot:UIImageView?
        
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
