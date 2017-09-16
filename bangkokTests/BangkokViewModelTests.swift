//
//  BangkokViewModelTests.swift
//  bangkok
//
//  Created by Shah Qays on 16/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import bangkok

class BangkokViewModelTests: XCTestCase {
    
    let viewModel = BangkokViewModel()
    
    let mockDataArray = [
        ["title": "Super Survey",
         "cover_image_url": "https://www.google.com/image",
         "description": "The Description Is"],
        ["title": "Survey Mania",
         "cover_image_url": "https://www.yahoo.com/image",
         "description":"Its survey mania"]
    ]
    
    //Given a JSON object with an array result should be an array with Surveys
    func testProcessSurvey() {
        
        let json = JSON(mockDataArray)
        
        let surveys = viewModel.processSurvey(json: json)
        
        let survey = surveys.first
        
        XCTAssertTrue(survey != nil)
    }
    
    func testProcessSurveyWithoutJSONArray() {
        
        let json = JSON(mockDataArray.first!)
        
        let surveys = viewModel.processSurvey(json: json)
        
        let survey = surveys.first
        
        XCTAssertTrue(survey == nil)
    }
    
}
