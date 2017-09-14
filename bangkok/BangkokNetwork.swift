//
//  BangkokNetwork.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Endpoints: String {
    case surveys = "https://nimbl3-survey-api.herokuapp.com/surveys.json"
}

class BangkokNetwork {
    
    let accessToken = "d9584af77d8c0d6622e2b3c554ed520b2ae64ba0721e52daa12d6eaa5e5cdd93"
    
    /**
     Get the survey JSON
     
     - Parameter completion: Returns surveys
    */
    func getSurvey(completion: @escaping (JSON)->Void) {
        
        let params = ["access_token": accessToken]
        
        Alamofire.request(Endpoints.surveys.rawValue, method: .get, parameters: params).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("json array \(json.array?.count ?? 0)")
                completion(json)
            case .failure(let error):
                let message = error.localizedDescription
            }
            
        }
    }
    
}
