//
//  ViewCoinDetailsList.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation
import UIKit

// Show a list of data items relating to the coin
// Could be a list view but decided to do it as a strip of views

class ViewCoinDetailsList: BaseView{
    // ============================================================================================================
    // view properties
    // ============================================================================================================
    
    
    // ============================================================================================================
    // Create the controls used in this view
    // ============================================================================================================
    // create subviews as static properties of this view
    
    private let txtTitle:PaddingLabel = {
        let title = PaddingLabel()
        title.font = AppStyle.fontDefault
        title.textAlignment = .left
        title.textColor = .black
        title.text = "More information:"
        title.backgroundColor = .white
        title.layer.cornerRadius = AppStyle.cornerRadius
        title.clipsToBounds = true
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    
    private let lineSupply: ViewListLine = {
        let line = ViewListLine(label: "Supply")
        line.layer.cornerRadius = AppStyle.cornerRadius
        line.clipsToBounds = true
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private let lineMaxSupply: ViewListLine = {
        let line = ViewListLine(label: "Max Supply")
        line.layer.cornerRadius = AppStyle.cornerRadius
        line.clipsToBounds = true
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private let lineVolume: ViewListLine = {
        let line = ViewListLine(label: "Volume (24hrs)")
        line.layer.cornerRadius = AppStyle.cornerRadius
        line.clipsToBounds = true
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private let lineMarketCap: ViewListLine = {
        let line = ViewListLine(label: "Market Cap")
        line.layer.cornerRadius = AppStyle.cornerRadius
        line.clipsToBounds = true
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    // ============================================================================================================
    // add subviews
    // ============================================================================================================
    
    override func addSubviews() {
        
        addSubview(txtTitle)
        
        
        addSubview(lineSupply)
        addSubview(lineMaxSupply)
        addSubview(lineVolume)
        addSubview(lineMarketCap)
        
    }
    // ============================================================================================================
    // add the constraints
    // ============================================================================================================
    
    
    // programmatically set up constraints
    override func addConstraints() {
        
        // use a layout guide to space out the lines
        let blockLayout = UILayoutGuide()
        addLayoutGuide(blockLayout)
        
        
        NSLayoutConstraint.activate([
            txtTitle.topAnchor.constraint(equalTo: topAnchor, constant: AppStyle.gap),
            txtTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: AppStyle.textMarginX),
            txtTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -AppStyle.textMarginX),
            txtTitle.heightAnchor.constraint(equalToConstant: AppStyle.heightTextline),
            
            lineSupply.topAnchor.constraint(equalTo: txtTitle.bottomAnchor, constant: AppStyle.gap),
            lineSupply.leftAnchor.constraint(equalTo: leftAnchor),
            lineSupply.rightAnchor.constraint(equalTo: rightAnchor),
            lineSupply.heightAnchor.constraint(equalToConstant: AppStyle.heightTextline),
            
            lineMaxSupply.topAnchor.constraint(equalTo: lineSupply.bottomAnchor, constant: AppStyle.gap),
            lineMaxSupply.leftAnchor.constraint(equalTo: leftAnchor),
            lineMaxSupply.rightAnchor.constraint(equalTo: rightAnchor),
            lineMaxSupply.heightAnchor.constraint(equalToConstant: AppStyle.heightTextline),
            
            lineVolume.topAnchor.constraint(equalTo: lineMaxSupply.bottomAnchor, constant: AppStyle.gap),
            lineVolume.leftAnchor.constraint(equalTo: leftAnchor),
            lineVolume.rightAnchor.constraint(equalTo: rightAnchor),
            lineVolume.heightAnchor.constraint(equalToConstant: AppStyle.heightTextline),
            
            lineMarketCap.topAnchor.constraint(equalTo: lineVolume.bottomAnchor, constant: AppStyle.gap),
            lineMarketCap.leftAnchor.constraint(equalTo: leftAnchor),
            lineMarketCap.rightAnchor.constraint(equalTo: rightAnchor),
            lineMarketCap.heightAnchor.constraint(equalToConstant: AppStyle.heightTextline),
            
            
            bottomAnchor.constraint(equalTo: lineMarketCap.bottomAnchor, constant: AppStyle.gap),
        ])
    }
    
    // ============================================================================================================
    // update this cell with the details of this coin
    // ============================================================================================================
    public func updateView(_ coin: ObjCoin){
        lineSupply.updateValue(value: coin.getSupply() == 0 ? "Unknown" : AppStyle.formatNumber(value: coin.getSupply(), dp:0))
        lineMaxSupply.updateValue(value: coin.getMaxSupply() == 0 ? "Unknown" : AppStyle.formatNumber(value: coin.getMaxSupply(), dp:0))
        lineVolume.updateValue(value: coin.getVolume() == 0 ? "Unknown" : AppStyle.formatCurrency(value: coin.getVolume(), dp:0))
        lineMarketCap.updateValue(value: coin.getMarketCap() == 0 ? "Unknown" : AppStyle.formatCurrency(value: coin.getMarketCap(), dp: 0 ))
        
    }
    // ============================================================================================================
    // ============================================================================================================

    
}
