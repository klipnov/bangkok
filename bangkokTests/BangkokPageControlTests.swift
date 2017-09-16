//
//  BangkokPageControlTests.swift
//  bangkok
//
//  Created by Shah Qays on 16/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
@testable import bangkok

class BangkokPageControlTests: XCTestCase {
    
    let bangkokPageControl = BangkokPageControl()
    
    func testBangkokPageControl() {
        
        bangkokPageControl.awakeFromNib()
        bangkokPageControl.numberOfPages = 5
        bangkokPageControl.currentPage = 3
        
        for (index,view) in bangkokPageControl.subviews.enumerated() {
            
            for subview in view.subviews {
                let point = CGFloat(index * 10)
                
                //page indicators must have 10 points gap on X axis between them
                XCTAssertEqual(subview.frame.origin.x, point)
                
                //page indicators must be an imageView
                XCTAssertTrue(subview is UIImageView)
            }
            
        }
        
    }
    
}
