//
//  AlertDisplaying.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

protocol AlertDisplaying { }

extension AlertDisplaying where Self: UIViewController {
    
    /**
     
     Show alerts from anywhere
     - Parameter title: Title of alert
     - Parameter message: Message of alert
     
     */
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
