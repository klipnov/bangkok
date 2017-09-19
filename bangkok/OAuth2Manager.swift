//
//  OAuth2Manager.swift
//  bangkok
//
//  Created by Shah Qays on 18/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class OAuth2Manager: RequestRetrier, RequestAdapter {
    
    private let accessToken: String
    
    init() {
        accessToken = "b29feeaa1bc105c8204099bd21311088b1c7e28b1d3f421fbe366304715e69f6"
    }
    
    private func initializeToken() {
        
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("bearer " + accessToken, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            print("failed to get authorization")
            getNewToken(completion: { (token) in
                print("new token \(token)")
            })
        }
    }
    
    private func getNewToken(completion: @escaping (String?) -> Void) {
        let params = ["grant_type": "password",
                      "username": "carlos@nimbl3.com",
                      "password": "antikera"]
        
        Alamofire.request(Endpoints.token.rawValue, method: .post, parameters: params).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let token = self.saveRefreshedToken(json: json)
                completion(token)
                break
            case .failure:
                completion(nil)
                break
            }
        }
    }
    
    private func saveRefreshedToken(json: JSON) -> String? {
        return "a new token"
    }
    
    private func getAccessToken() -> String? {
        return "current token"
    }

    
}
