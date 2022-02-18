//
//  ExtensionViewAutoLayout.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//


import Foundation
import UIKit



public extension UIView {

    // create the constraints to snap this view to the bounds of another view using autolayout
    // (saves 4 lines of code somewhere)
    func snapToView(_ thisView:UIView){
        topAnchor.constraint(equalTo: thisView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: thisView.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: thisView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: thisView.rightAnchor).isActive = true
    }
      
}
