//
//  ViewCoinHeader.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation
import UIKit

// Simple header row for the list view
// Similar to the View Coin Row but created as a new View as we may want to add sort buttons in the future
class ViewCoinHeader: BaseView{
    
    // ============================================================================================================
    // view properties
    // ============================================================================================================
    override func setupView() {
        // set the header background
        backgroundColor = AppStyle.colorTableViewHeaderBG
    }
    
    // ============================================================================================================
    // Create the controls used in this view
    // ============================================================================================================
    // create subviews as static properties of this view
    private let txtRank:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "#"
        label.textColor = AppStyle.colorTextTableViewHeader
        label.font = AppStyle.fontTableViewHeader
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let txtName:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Coin"
        label.textColor = AppStyle.colorTextTableViewHeader
        label.font = AppStyle.fontTableViewHeader
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let txtPrice:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Price"
        label.textColor = AppStyle.colorTextTableViewHeader
        label.font = AppStyle.fontTableViewHeader
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let txtChange:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "+/-"
        label.textColor = AppStyle.colorTextTableViewHeader
        label.font = AppStyle.fontTableViewHeader
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // ============================================================================================================
    // add subviews
    // ============================================================================================================
    
    override func addSubviews() {
        
        addSubview(txtRank)
        addSubview(txtName)
        addSubview(txtPrice)
        addSubview(txtChange)
        
    }
    // ============================================================================================================
    // add the constraints
    // ============================================================================================================
    
    
    // programmatically set up constraints
    override func addConstraints() {
        
        NSLayoutConstraint.activate([
            
            txtRank.leftAnchor.constraint(equalTo: leftAnchor),
            txtRank.centerYAnchor.constraint(equalTo: centerYAnchor),
            txtRank.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AppStyle.multiplierCol1),
            txtRank.heightAnchor.constraint(equalTo: heightAnchor),
            
            
            txtName.leftAnchor.constraint(equalTo: txtRank.rightAnchor),
            txtName.centerYAnchor.constraint(equalTo: centerYAnchor),
            txtName.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AppStyle.multiplierCol2),
            txtName.heightAnchor.constraint(equalTo: heightAnchor),
            
            txtPrice.leftAnchor.constraint(equalTo: txtName.rightAnchor, constant: AppStyle.gap),
            txtPrice.centerYAnchor.constraint(equalTo: centerYAnchor),
            txtPrice.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AppStyle.multiplierCol3),
            txtPrice.heightAnchor.constraint(equalTo: heightAnchor),
            
            // the change is anchored to the right hand side
            txtChange.rightAnchor.constraint(equalTo: rightAnchor, constant: -AppStyle.textMarginX),
            txtChange.centerYAnchor.constraint(equalTo: centerYAnchor),
            txtChange.widthAnchor.constraint(equalTo: widthAnchor, multiplier: AppStyle.multiplierCol4),
            txtChange.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
    
    // ============================================================================================================
    // ============================================================================================================
}
