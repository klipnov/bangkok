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
    
    func testIncreaseViewGap() {
        
        let firstView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        let secondView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        bangkokPageControl.increaseViewGap(index: 0, view: firstView)
        
        bangkokPageControl.increaseViewGap(index: 1, view: secondView)
        
        XCTAssertEqual(firstView.frame.origin.x, 0)
        XCTAssertEqual(secondView.frame.origin.x, 10)
    }
    
    
    
}
