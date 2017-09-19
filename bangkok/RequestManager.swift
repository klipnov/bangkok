//
//  RequestManager.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestManager: Alertable {
    
    let sessionManager = SessionManager()
    let oauthManager = OAuth2Manager()
    
    init() {
        sessionManager.retrier = oauthManager
        sessionManager.adapter = oauthManager
    }
    
    /**
     Get the survey JSON
     
     - Parameter completion: Returns surveys
    */
    func getSurveyJSON(completion: @escaping (JSON?)->Void) {
        
        checkForRepeatedRequest(stringURL: Endpoints.surveys.rawValue)
        
        sessionManager.request(Endpoints.surveys.rawValue).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                completion(nil)
                self.showAlert(title: "Network Error", message: error.localizedDescription)
            }
        }
        
    }
    
    /**
     Check for repeated calls
     
     - Parameter stringURL: url string to check
    */
    private func checkForRepeatedRequest(stringURL: String) {
        sessionManager.session.getTasksWithCompletionHandler { (dataTask, uploadTask, downloadTask) in
            
            dataTask.forEach({ (dataTask) in
                if dataTask.originalRequest?.urlRequest?.url?.absoluteString == stringURL {
                    print("cancelling requests")
                    dataTask.cancel()
                }
            })
            
        }
    }
    
}
