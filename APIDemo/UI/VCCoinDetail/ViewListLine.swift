//
//  ViewListLine.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation
import UIKit

// Simple reusable view that displays a value and label on a single line with a background
class ViewListLine: BaseView{
    
    // allow a label to passed in with initialisation
    convenience init(label:String){
        self.init()
        
        // update the label text
        txtLabel.text = label
    }
    
    // ============================================================================================================
    // Create the controls used in this view
    // ============================================================================================================
    // create subviews as static properties of this view
    
    private let txtLabel:PaddingLabel = {
        let label = PaddingLabel()
        label.font = AppStyle.fontDefault
        label.textAlignment = .left
        label.textColor = .black
        label.text = ""
        label.backgroundColor = .white
        label.layer.cornerRadius = AppStyle.cornerRadius
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let txtValue:UILabel = {
        let labelValue = UILabel()
        labelValue.font = AppStyle.fontDefault
        labelValue.textAlignment = .right
        labelValue.textColor = .black
        labelValue.text = "0"
        labelValue.backgroundColor = .white
        labelValue.layer.cornerRadius = AppStyle.cornerRadius
        labelValue.clipsToBounds = true
        labelValue.translatesAutoresizingMaskIntoConstraints = false
        return labelValue
    }()
    
    
    // ============================================================================================================
    // add subviews
    // ============================================================================================================
    
    override func addSubviews() {
        
        addSubview(txtLabel)
        addSubview(txtValue)
        
    }

    // ============================================================================================================
    // add the constraints
    // ============================================================================================================
    
    
    // programmatically set up constraints
    override func addConstraints() {
        
        NSLayoutConstraint.activate([
            txtLabel.topAnchor.constraint(equalTo: topAnchor),
            txtLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: AppStyle.textMarginX),
            txtLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -AppStyle.textMarginX),
            txtLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            txtValue.centerYAnchor.constraint(equalTo: txtLabel.centerYAnchor),
            txtValue.rightAnchor.constraint(equalTo: txtLabel.rightAnchor, constant: -AppStyle.textMarginX),
            txtValue.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
        ])
    }
    
    // ============================================================================================================
    // ============================================================================================================
    
    // update value
    func updateValue(value:String){
        txtValue.text = value
    }
    // ============================================================================================================
    // ============================================================================================================
    
}
