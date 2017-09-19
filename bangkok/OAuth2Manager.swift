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
import KeychainSwift

class OAuth2Manager: RequestRetrier, RequestAdapter {
    
    private var accessToken = ""
    private let keychain = KeychainSwift()
    private let accessTokenKey = "accessToken"
    
    init() {
        accessToken = getAccessToken()
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("bearer " + accessToken, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            print("failed to get authorization")
            getNewToken(completion: { (success) in
                if success {
                    completion(true, 0.0)
                } else {
                    completion(false, 1.0)
                }
            })
        }
    }
    
    private func getNewToken(completion: @escaping (Bool) -> Void) {
        let params = ["grant_type": "password",
                      "username": "carlos@nimbl3.com",
                      "password": "antikera"]
        
        Alamofire.request(Endpoints.token.rawValue, method: .post, parameters: params).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.saveRefreshedToken(json: json)
                completion(true)
                break
            case .failure:
                completion(false)
                break
            }
        }
    }
    
    private func saveRefreshedToken(json: JSON) {
        if let accessTokenString = json["access_token"].string {
          keychain.set(accessTokenString, forKey: accessTokenKey)
          accessToken = accessTokenString
        }
    }
    
    private func getAccessToken() -> String {
        
        if let accessToken = keychain.get(accessTokenKey) {
            return accessToken
        }
        
        return ""
    }

    
}
