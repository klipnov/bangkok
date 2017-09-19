//
//  Appearances.swift
//  bangkok
//
//  Created by Shah Qays on 15/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class AppearanceConfigurator {
    /**
     
     Change Navigation Bar Appearance to Bangkok UI
     
     */
    
    static func adjustNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.barTintColor = UIColor.init(red: 17.0/255.0, green: 28.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBarAppearance.tintColor = UIColor.white
    }
    
}
