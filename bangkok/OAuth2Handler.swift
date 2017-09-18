//
//  OAuth2Handler.swift
//  bangkok
//
//  Created by Shah Qays on 18/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class OAuth2Handler: RequestRetrier {
    
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            getNewToken(completion: { (json) in
                //insert new token into Token managedObject
            })
        }
    }
    
    private func getNewToken(completion: @escaping (JSON?) -> Void) {
        let params = ["grant_type": "password",
                      "username": "carlos@nimbl3.com",
                      "password": "antikera"]
        
        Alamofire.request(Endpoints.token.rawValue, method: .post, parameters: params).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
                break
            case .failure(let error):
                completion(nil)
                break
            }
        }
    }
    
    private func saveRefreshedToken(json: JSON) {
        
        let context = GlobalVariables.context
        
        let tokenFetch: NSFetchRequest<Token> = Token.fetchRequest()
        
        do {
            let fetchedToken = try context.fetch(tokenFetch) 
            
            let token: Token!
            // create new token if there is no token
            if fetchedToken.count == 0 {
                token = Token(entity: Token.entity(), insertInto: context)
            } else {
            // override the old token
                token = fetchedToken.first
            }
            
            token.accessToken = json["access_token"].string
            token.expiresIn = Int64(json["expires_in"].intValue)
            token.tokenType = json["token_type"].string
            token.createdAt = Int64(json["created_at"].intValue)
            
            do {
                try context.save()
            } catch {
                print("failed fetch", error)
            }
            
        } catch {
            print("failed fetch", error)
        }
        
    }

    
}
