//
//  ViewPriceHistory.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import UIKit

// Custom view component to display a table of price history
class ViewPriceHistory: UIView {
    // ============================================================
    // Data
    // ============================================================
    
    var prices:[ObjPrice] = [ObjPrice]()
    
    // ============================================================
    // ============================================================
    
    convenience init(prices:[ObjPrice]){
        self.init()
        self.prices = prices
        calcPrices()
    }
    // ============================================================
    // ============================================================
    
    // display a new bunch of prices
    func updatePrices(_ newPrices:[ObjPrice]){
        
        prices = newPrices
        calcPrices()
        calcLayout()
        setNeedsDisplay()
    }
    
    // we need to come up with a bunch of price points to display
    // i.e. 1d 1w 1m 3m 6m 1y
    // The data series might be of variable length so we will add in the ones we can
    // It might also be worth attempting different sets for different length of series
    // i.e.
    // 1y of data -> 1d 1w 1m 3m 6m 1y
    // 3m of data -> 1d 1w 2w 1m 2m 3m
    
    var pricePoints = [(Int,Double, String)]()
    
    func calcPrices(){
        pricePoints.removeAll()
        addPricePoint(day: 360, label: "1y")
        addPricePoint(day: 180, label: "6m")
        addPricePoint(day: 90, label: "3m")
        addPricePoint(day: 30, label: "1m")
        addPricePoint(day: 7, label: "1w")
        addPricePoint(day: 1, label: "1d")
    }
    
    // add this pricepoint to the list if we can
    func addPricePoint(day:Int, label:String){
        if let lastPrice = prices.last{
            if day < prices.count && lastPrice.price > 0{
                let priceReturn = (lastPrice.price / prices[prices.count - 1 - day].price )-1
                pricePoints.append((day, priceReturn , label))
            }
        }
    }
    
    // ============================================================
    // Layout
    // ============================================================
    
    // Whenever we are laid out we can recalculate our layout
    // that saves us having to do it in every draw cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        calcLayout()
        
    }
    
    var w:CGFloat = 0
    var h:CGFloat = 0
    var barHeight:CGFloat = 0
    
    var topBar:CGRect = CGRect.zero
    var bottomBar:CGRect = CGRect.zero
    
    var boxWidth:CGFloat = 0
    
    var textAttributes:[NSAttributedString.Key : Any]!
    var textAttributesUp:[NSAttributedString.Key : Any]!
    var textAttributesDown:[NSAttributedString.Key : Any]!
    
    func calcLayout(){
        w = bounds.size.width
        h = bounds.size.height
        barHeight = h/2
        
        if pricePoints.count > 0{
            boxWidth = w/CGFloat(pricePoints.count)
        }else{
            boxWidth = 0
        }
        
        topBar = CGRect(x: 0, y: 0, width: w, height: barHeight)
        bottomBar = CGRect(x: 0, y: barHeight, width: w, height: barHeight)
        
        textAttributes = [
            NSAttributedString.Key.font : AppStyle.fontPriceHistoryHeader,
            NSAttributedString.Key.foregroundColor : AppStyle.colorDefaultText,
        ]
        textAttributesUp = [
            NSAttributedString.Key.font : AppStyle.fontPriceHistory,
            NSAttributedString.Key.foregroundColor : AppStyle.colorTextUp,
        ]
        textAttributesDown = [
            NSAttributedString.Key.font : AppStyle.fontPriceHistory,
            NSAttributedString.Key.foregroundColor : AppStyle.colorTextDown,
        ]
        
    }
    // ============================================================
    // ============================================================
    
    
    // ============================================================
    // ============================================================
    
    
    // draw the price histor
    override func draw(_ rect: CGRect) {
        // keep it simple
        if let context = UIGraphicsGetCurrentContext(){
            
            
            // draw top bar
            context.setFillColor(AppStyle.colorTableViewHeaderBG.cgColor)
            context.fill(topBar)
            
            // draw bottom bar
            context.setFillColor(AppStyle.colorBG.cgColor)
            context.fill(bottomBar)
            
            // draw price history boxes
            for (i,p) in pricePoints.enumerated(){
                
                let (_, priceReturn, label) = p
                
                let x = (CGFloat(i)+0.5)*boxWidth
                let y = barHeight/2
                
                // draw label
                let text = NSString(string: label)
                let ts = text.size(withAttributes: textAttributes)
                text.draw(in: CGRect(origin: CGPoint(x:x-ts.width/2, y:y-ts.height/2), size: ts), withAttributes: textAttributes)
                
                // draw price change
                let textPrice = NSString(string: String(format: "%.2f", priceReturn*100) + "%")
                let tsPrice = textPrice.size(withAttributes: textAttributesUp)
                textPrice.draw(in: CGRect(origin: CGPoint(x:x-tsPrice.width/2, y:y+barHeight-tsPrice.height/2), size: tsPrice), withAttributes: priceReturn >= 0 ? textAttributesUp : textAttributesDown)
                
            }
            
            
        }
    }
    
    // ============================================================
    // ============================================================
    // ============================================================
    // ============================================================

}
