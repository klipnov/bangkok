//
//  Alertable.swift
//  bangkok
//
//  Created by Shah Qays on 14/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

protocol Alertable { }

extension Alertable {
    func showAlert(message: String) {
        let topViewController = UIViewController()
        let alertController = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        topViewController.present(alertController, animated: true, completion: nil)
    }
}
