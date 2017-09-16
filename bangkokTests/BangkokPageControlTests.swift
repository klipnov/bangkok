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
    
    // Given two views at the same location and size
    // after going through the function
    // the secondView should be 10 points futher
    // on the x-axis
    func testIncreaseViewGap() {
        
        let firstView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        let secondView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        bangkokPageControl.increaseViewGap(index: 0, view: firstView)
        
        bangkokPageControl.increaseViewGap(index: 1, view: secondView)
        
        XCTAssertEqual(firstView.frame.origin.x, 0)
        XCTAssertEqual(secondView.frame.origin.x, 10)
    }
    
    // Given a UIView, it should return nil if 
    // there is no imageView in subviews
    func testImageForSubview() {
        
        let view = UIView()
        
        let viewWithImageView = UIView()
        viewWithImageView.addSubview(UIImageView(frame: CGRect.zero))
        
        let firstImageView = bangkokPageControl.imageForSubview(view)
        
        let secondImageView = bangkokPageControl.imageForSubview(viewWithImageView)
        
        XCTAssertNil(firstImageView)
        XCTAssertTrue((secondImageView != nil))
        
    }
    
}
