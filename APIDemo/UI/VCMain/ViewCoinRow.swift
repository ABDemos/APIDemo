//
//  ViewCoinRow.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//


import Foundation
import UIKit

// this defines the view for a row in the coin list
class ViewCoinRow:BaseView{
    
    // ============================================================================================================
    // view properties
    // ============================================================================================================
    
    
    // ============================================================================================================
    // Create the controls used in this view
    // ============================================================================================================
    // create subviews as static properties of this view
    private let txtRank:UILabel = {
        let l = UILabel()
        l.font = AppStyle.fontTableViewCell
        l.textAlignment = .center
        l.textColor = AppStyle.colorDefaultText
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let txtName:UILabel = {
        let l = UILabel()
        l.font = AppStyle.fontTableViewCellMedium
        l.textAlignment = .center
        l.textColor = AppStyle.colorDefaultText
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let txtPrice:UILabel = {
        let l = UILabel()
        l.font = AppStyle.fontTableViewCellPrice
        l.textAlignment = .center
        l.textColor = AppStyle.colorDefaultText
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let txtChange:UILabel = {
        let l = UILabel()
        l.font = AppStyle.fontTableViewCellChange
        l.textAlignment = .center
        l.textColor = AppStyle.colorChange
        l.layer.cornerRadius = AppStyle.cornerRadius
        l.clipsToBounds = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
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
            txtChange.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
        ])
    }
    
    // ============================================================================================================
    // update this cell with the details of this coin
    // ============================================================================================================
    public func updateView(_ coin: ObjCoin){
        
        txtRank.text = coin.rank
        txtName.text = coin.name
        txtPrice.text = AppStyle.formatCurrency(value: coin.getPrice(), dp:2)
        
        // price change requires colorisation
        let change = coin.getChange()
        txtChange.text = "\(change>0 ? "+" : "")\(String(format: "%.2f", change))%"
        txtChange.backgroundColor = coin.getChange() >= 0 ? AppStyle.colorTextUp : AppStyle.colorTextDown
        
    }
    
}
