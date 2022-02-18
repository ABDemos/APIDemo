//
//  ViewPriceBoxes.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation
import UIKit

// Show some boxes with price, change and VWAP
class ViewPriceBoxes : BaseView{
    
    // ============================================================================================================
    // view properties
    // ============================================================================================================
    
    
    // ============================================================================================================
    // Create the controls used in this view
    // ============================================================================================================
    // ========================================================
    // Info block
    // ========================================================
    
    static let defaultCurrencyText:String = "$0.00"
    
    // price
    private let txtPrice:UILabel = {
        let price = UILabel()
        price.font = AppStyle.fontDefault
        price.textAlignment = .center
        price.textColor = AppStyle.colorTextInverse
        price.text = ViewPriceBoxes.defaultCurrencyText
        price.backgroundColor = AppStyle.colorDefaultText
        price.layer.cornerRadius = AppStyle.cornerRadius
        price.clipsToBounds = true
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private let txtPriceText:UILabel = {
        let priceText = UILabel()
        priceText.font = AppStyle.fontDefault
        priceText.textAlignment = .center
        priceText.textColor = AppStyle.colorDefaultText
        priceText.text = "Price"
        priceText.translatesAutoresizingMaskIntoConstraints = false
        return priceText
    }()
    
    
    private let txtChange:UILabel = {
        let change = UILabel()
        change.font = AppStyle.fontPriceLarge
        change.textAlignment = .center
        change.textColor = AppStyle.colorChange
        change.text = "-"
        change.backgroundColor = .lightGray
        change.layer.cornerRadius = AppStyle.cornerRadius
        change.clipsToBounds = true
        change.translatesAutoresizingMaskIntoConstraints = false
        return change
    }()
    
    private let txtChangeText:UILabel = {
        let changeText = UILabel()
        changeText.font = AppStyle.fontDefault
        changeText.textAlignment = .center
        changeText.textColor = AppStyle.colorDefaultText
        changeText.text = "+/- 24h"
        changeText.translatesAutoresizingMaskIntoConstraints = false
        return changeText
    }()
    
    private let txtVWAP:UILabel = {
        let vwap = UILabel()
        vwap.font = AppStyle.fontDefault
        vwap.textAlignment = .center
        vwap.textColor = AppStyle.colorTextInverse
        vwap.text = ViewPriceBoxes.defaultCurrencyText
        vwap.backgroundColor = AppStyle.colorDefaultText
        vwap.layer.cornerRadius = AppStyle.cornerRadius
        vwap.clipsToBounds = true
        vwap.translatesAutoresizingMaskIntoConstraints = false
        return vwap
    }()
    
    private let textVWAPText:UILabel = {
        let vwapText = UILabel()
        vwapText.font = AppStyle.fontDefault
        vwapText.textAlignment = .center
        vwapText.textColor = AppStyle.colorDefaultText
        vwapText.text = "VWAP 24h"
        vwapText.translatesAutoresizingMaskIntoConstraints = false
        return vwapText
    }()
    
    
    
    // ============================================================================================================
    // add subviews
    // ============================================================================================================
    
    override func addSubviews() {
        
        addSubview(txtPrice)
        addSubview(txtPriceText)
        addSubview(txtChange)
        addSubview(txtChangeText)
        addSubview(txtVWAP)
        addSubview(textVWAPText)
        
    }
    // ============================================================================================================
    // add the constraints
    // ============================================================================================================
    
    // programmatically set up constraints
    override func addConstraints() {
        
        // use a layout guide to equally space the blocks
        let blockLayout = UILayoutGuide()
        addLayoutGuide(blockLayout)
        
        
        NSLayoutConstraint.activate([
            // put a layout in so that we can arrange our button
            blockLayout.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
            blockLayout.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // info block
            txtPrice.widthAnchor.constraint(equalTo: blockLayout.widthAnchor, multiplier: 1/3, constant: -2*AppStyle.gap),
            txtPrice.topAnchor.constraint(equalTo: topAnchor, constant: AppStyle.gapBig),
            txtPrice.leftAnchor.constraint(equalTo: blockLayout.leftAnchor, constant: AppStyle.gap),
            txtPrice.heightAnchor.constraint(equalToConstant: AppStyle.heightBlock),
            
            txtPriceText.widthAnchor.constraint(equalTo: txtPrice.widthAnchor),
            txtPriceText.topAnchor.constraint(equalTo: txtPrice.bottomAnchor, constant: AppStyle.gap),
            txtPriceText.centerXAnchor.constraint(equalTo: txtPrice.centerXAnchor),
            
            // change
            txtChange.widthAnchor.constraint(equalTo: blockLayout.widthAnchor, multiplier: 1/3, constant: -2*AppStyle.gap),
            txtChange.centerYAnchor.constraint(equalTo: txtPrice.centerYAnchor),
            txtChange.leftAnchor.constraint(equalTo: txtPrice.rightAnchor, constant: 2*AppStyle.gap),
            txtChange.heightAnchor.constraint(equalToConstant: AppStyle.heightButton),
            
            txtChangeText.widthAnchor.constraint(equalTo: txtChange.widthAnchor),
            txtChangeText.topAnchor.constraint(equalTo: txtChange.bottomAnchor, constant: AppStyle.gap),
            txtChangeText.centerXAnchor.constraint(equalTo: txtChange.centerXAnchor),
            
            // volume
            txtVWAP.widthAnchor.constraint(equalTo: blockLayout.widthAnchor, multiplier: 1/3, constant: -2*AppStyle.gap),
            txtVWAP.centerYAnchor.constraint(equalTo: txtPrice.centerYAnchor),
            txtVWAP.leftAnchor.constraint(equalTo: txtChange.rightAnchor, constant: 2*AppStyle.gap),
            txtVWAP.heightAnchor.constraint(equalToConstant: AppStyle.heightButton),
            
            textVWAPText.widthAnchor.constraint(equalTo: txtVWAP.widthAnchor),
            textVWAPText.topAnchor.constraint(equalTo: txtVWAP.bottomAnchor, constant: AppStyle.gap),
            textVWAPText.centerXAnchor.constraint(equalTo: txtVWAP.centerXAnchor),
        ])
    }
    
    // ============================================================================================================
    // update this cell with the details of this coin
    // ============================================================================================================
    public func updateView(_ coin: ObjCoin){
        
        txtPrice.text = AppStyle.formatCurrency(value: coin.getPrice())
        
        let pctChange = coin.getChange()
        txtChange.text = "\(pctChange>0 ? "+" : "")\(String(format: "%.2f", pctChange))%"
        txtChange.backgroundColor = pctChange >= 0 ? AppStyle.colorTextUp : AppStyle.colorTextDown
        
        txtVWAP.text = AppStyle.formatCurrency(value: coin.getVWAP())
    }
    
    // ============================================================================================================
    // ============================================================================================================

}
