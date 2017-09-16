//
//  BangkokPageControl.swift
//  bangkok
//
//  Created by Shah Qays on 15/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

// PageControl subclass for custom dots
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
        
        // rotate the page control 90 degress
        let angle = CGFloat(Double.pi/2)
        self.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    /**
     
     Updates the subviews of pageControl and assigns the currentPage activeImage
     
     */
    
    func updateDots() {
        
        // Enumerate through every pageControl subview to
        // find or create an imageView
        // also sets the active image according to the currentPage
        for (index,view) in self.subviews.enumerated() {
            
            //if imageView is found set it to active or inactive image
            if let imageView = self.imageForSubview(view) {
                
                //if current imageView sequence is equal currentPage
                if index == self.currentPage {
                    //set to activeImage
                    imageView.image = self.activeImage
                } else {
                    //set to inactiveImage
                    imageView.image = self.inactiveImage
                }
                
            } else {
                // else add an imageView to pageControl subviews
                var dotImage = self.inactiveImage
                
                // set active image if index equals current page
                if index == self.currentPage {
                    dotImage = self.activeImage
                }
                
                view.clipsToBounds = false // so that imageView assigned can be seen
                
                //assign imageView to current view
                let imageView = UIImageView(image: dotImage)
                view.addSubview(imageView)
                
                //increase the gap between dots
                increaseViewGap(index: index, view:imageView)
                
            }
        }
    }
    
    /**
     
     Moves PageControl dots further apart on X Axis
     
     - Parameter index: Index of the view
     - Parameter view: View that needs to change it's X Axis
     
     */
    
    func increaseViewGap(index:Int ,view: UIView) {
        
            let frame = view.frame
        
            view.frame = CGRect(
                //add 10 points on X
                x: CGFloat(Int(frame.origin.x) + (10 * index)),
                y: frame.origin.y,
                width: frame.width,
                height: frame.height)
    }
    
    /**
     
     Finds UIImageView in subviews
     
     - Parameter view: UIView
     
     - Returns: found imageView
     
    */
    
    func imageForSubview(_ view:UIView) -> UIImageView? {
        
        //if the view is an imageView
        if let dotImageView = view as? UIImageView {
            // return the imageView
            return dotImageView
        } else {
            // else try and find imageView in it's subviews
            for foundView in view.subviews {
                //if imageView is found
                if let imageView = foundView as? UIImageView {
                    //return the imageView
                    return imageView
                }
            }
        }
        
        // return nil if everything fails
        return nil
    }
    
}
