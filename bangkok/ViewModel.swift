//
//  ViewModel.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import SwiftyJSON

class ViewModel {
    
    var surveys = [Survey]()
    var didUpdateSurvey: (() -> Void)?

    init() {
        refreshSurvey()
    }
    
    /**
     Returns an array of surveys
    */
    func getSurvey() {        
        BangkokNetwork.getSurveyJSON { (json) in
            guard let json = json else {
                return
            }
            self.processSurvey(json: json)
            self.didUpdateSurvey?()
        }
    } 
    
    /**
     Clears the surveys and re-download again
     */
    func refreshSurvey() {
        surveys.removeAll()
        getSurvey()
    }
    
    /**
     Process the survey to populate data
     */
    func processSurvey(json: JSON) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        for json in json.array! {
            let survey = Survey(entity: Survey.entity(), insertInto: context)
            
            survey.title = json["title"].string
            survey.imageURL = json["cover_image_url"].string?.appending("l")
            survey.surveyDescription = json["description"].string
            
            surveys.append(survey)
        }
    }
}
