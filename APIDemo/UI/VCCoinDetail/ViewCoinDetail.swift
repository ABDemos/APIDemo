//
//  ViewCoinDetail.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation
import UIKit

class ViewCoinDetail: BaseView{
    
    
    // ============================================================================================================
    // view properties
    // ============================================================================================================
    override func setupView() {
        // set the header background
        backgroundColor = AppStyle.colorBG
    }
    
    // ============================================================================================================
    // Create the controls used in this view
    // ============================================================================================================
    // create subviews as static properties of this view
    
    // ========================================================
    // Title and subtitle
    // ========================================================
    
    private let title:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Coin Name"
        label.textColor = AppStyle.colorDefaultText
        label.font = AppStyle.fontTitleLarge
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let subtitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "(Coin Symbol)"
        label.textColor = AppStyle.colorDefaultText
        label.font = AppStyle.fontTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewPriceBoxes:ViewPriceBoxes = {
        let viewPriceBoxes = ViewPriceBoxes()
        viewPriceBoxes.translatesAutoresizingMaskIntoConstraints = false
        
        return viewPriceBoxes
        
    }()
    
    private let priceHistory:ViewPriceHistory = {
        let viewPriceHistory = ViewPriceHistory()
        viewPriceHistory.translatesAutoresizingMaskIntoConstraints = false
        return viewPriceHistory
        
    }()
    
    private let graphTitle:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Pricing History"
        label.textColor = AppStyle.colorTextTableViewHeader
        label.font = AppStyle.fontDefault
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let graph:ViewGraph = {
        let viewGraph = ViewGraph()
        viewGraph.layer.cornerRadius = AppStyle.cornerRadius
        viewGraph.clipsToBounds = true
        viewGraph.translatesAutoresizingMaskIntoConstraints = false
        return viewGraph
    }()
    
    private let coinDetailsList: ViewCoinDetailsList = {
        let details = ViewCoinDetailsList()
        details.translatesAutoresizingMaskIntoConstraints = false
        return details
    }()
    
    // put everything in a scroll view just in case it spills off the end of the screen
    private let scrollView:UIScrollView = {
        let scroller = UIScrollView()
        scroller.translatesAutoresizingMaskIntoConstraints = false
        return scroller
    }()
    
    
    // ============================================================================================================
    // add subviews
    // ============================================================================================================
    
    override func addSubviews() {
        
        addSubview(scrollView)
        
        // now the rest of the controls go into the scrollview
        scrollView.addSubview(title)
        scrollView.addSubview(subtitle)
        
        scrollView.addSubview(viewPriceBoxes)
        
        scrollView.addSubview(priceHistory)
        
        scrollView.addSubview(graphTitle)
        scrollView.addSubview(graph)
        scrollView.addSubview(coinDetailsList)
        
    }
    // ============================================================================================================
    // add the constraints
    // ============================================================================================================
    
    
    // programmatically set up constraints
    override func addConstraints() {
        
        // quick snap the scroll view
        scrollView.snapToView(self)
        
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: AppStyle.gap),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.widthAnchor.constraint(equalTo: widthAnchor, constant: -2*AppStyle.textMarginX),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: AppStyle.gap),
            subtitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            subtitle.widthAnchor.constraint(equalTo: title.widthAnchor),
            
            viewPriceBoxes.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: AppStyle.gapBig),
            viewPriceBoxes.widthAnchor.constraint(equalTo: widthAnchor),
            viewPriceBoxes.heightAnchor.constraint(equalTo: viewPriceBoxes.widthAnchor, multiplier: 1/4),
            viewPriceBoxes.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            priceHistory.topAnchor.constraint(equalTo: viewPriceBoxes.bottomAnchor, constant: AppStyle.gapBig),
            priceHistory.widthAnchor.constraint(equalTo: widthAnchor),
            priceHistory.heightAnchor.constraint(equalTo: priceHistory.widthAnchor, multiplier: 2/6),
            priceHistory.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            graphTitle.topAnchor.constraint(equalTo: priceHistory.bottomAnchor, constant: AppStyle.gap),
            graphTitle.centerXAnchor.constraint(equalTo: graph.centerXAnchor),
            graphTitle.widthAnchor.constraint(equalTo: graph.widthAnchor),
            
            graph.topAnchor.constraint(equalTo: graphTitle.bottomAnchor, constant: AppStyle.gap),
            graph.widthAnchor.constraint(equalTo: widthAnchor, constant: -2*AppStyle.gap),
            graph.heightAnchor.constraint(equalTo: graph.widthAnchor, multiplier: 0.5),
            graph.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            coinDetailsList.topAnchor.constraint(equalTo: graph.bottomAnchor, constant: 2*AppStyle.gap),
            coinDetailsList.widthAnchor.constraint(equalTo: widthAnchor),
            coinDetailsList.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            scrollView.bottomAnchor.constraint(equalTo: coinDetailsList.bottomAnchor, constant: AppStyle.gapBig),
        ])
    }
    
    // ============================================================================================================
    // Updates
    // ============================================================================================================

    
    // update all the subviews with the information they need
    func updateView(coin:ObjCoin, prices:[ObjPrice]){
        
        title.text = coin.name
        subtitle.text = "(\(coin.symbol))"
        
        viewPriceBoxes.updateView(coin)
        
        coinDetailsList.updateView(coin)
        
        graph.updatePrices(prices)
        priceHistory.updatePrices(prices)
        
        
        updateGraphTitle(prices:prices)
    }
    
    
    // update the graph title based on the number of prices we have
    func updateGraphTitle(prices:[ObjPrice]){
        
        if prices.count > 0{
            graphTitle.text = "Price History (\(prices.count) days)"
        }else{
            graphTitle.text = "Price History (No data)"
        }
        
    }
    // ============================================================================================================
    // ============================================================================================================
    
}
