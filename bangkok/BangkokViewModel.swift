//
//  BangkokViewModel.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Gets and processes Survey data
class BangkokViewModel {
    
    var surveys = [Survey]()
    var didUpdateSurvey: (() -> Void)?
    var requestError:((Error)->Void)?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestManager = RequestManager()

    init() {}
    
    /**
     
     Downloads surveys, process and update viewModel
     
    */
    
    func getSurvey() {
        requestManager.getSurveyJSON { (json,error) in
            guard let json = json else {
                if let error = error {
                    self.requestError?(error)
                }
                return
            }
            self.surveys = self.processSurvey(json: json)
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
     
     - Parameter json: json to turn into Surveys
     
     */
    
    private func processSurvey(json: JSON) -> [Survey] {
        
        var surveys = [Survey]()
        
        guard (json.array != nil) else {
            return surveys
        }
        
        for json in json.array! {
            let survey = Survey(entity: Survey.entity(), insertInto: context)
            
            survey.title = json["title"].string
            survey.imageURL = json["cover_image_url"].string?.appending("l")
            survey.surveyDescription = json["description"].string
            
            surveys.append(survey)
        }
        
        return surveys
    }
}
