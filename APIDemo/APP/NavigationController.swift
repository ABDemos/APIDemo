//
//  NavigationController.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import UIKit


// Custom navigation controller to allow us to stlye the navigation bar
class NavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style the appearance of the nav controller
        navigationBar.barStyle = .default
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [.foregroundColor: AppStyle.colorDefaultText]
        navigationBar.tintColor = AppStyle.colorDefaultText

        // setup the appearance of the navigation bar so that we don't get the jump to white with scrollviews
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = AppStyle.colorBG
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppStyle.colorDefaultText]
            
            navigationBar.prefersLargeTitles = false
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        }
        
        
    }
    
}
