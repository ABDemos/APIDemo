//
//  ViewGraph.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import UIKit

// Custom view component to display price history as a graph
// (with a bit of animation)
class ViewGraph: UIView {
    // ============================================================
    // Data
    // ============================================================
    
    var prices:[ObjPrice] = [ObjPrice]()
    
    var maxPrice:CGFloat = 0
    var minPrice:CGFloat = 0
    // ============================================================
    // ============================================================
    // colors
    let colorAxis:CGColor = UIColor.black.cgColor
    let colorGridlines:CGColor = UIColor.darkGray.cgColor
    let colorPlot:CGColor = UIColor.black.cgColor
    // ============================================================
    // ============================================================
    
    convenience init(prices:[ObjPrice]){
        self.init()
        self.prices = prices
    }
    // ============================================================
    // ============================================================
    
    // ============================================================
    // ============================================================
    
    // When the price data is updated we need to calculate sizes and offsets for the graph
    func updatePrices(_ newPrices:[ObjPrice]){
        
        prices = newPrices
        
        // size up the graph now
        maxPrice = 0
        minPrice = 100000000000
        for p in prices{
            maxPrice = max(maxPrice, p.price)
            minPrice = min(minPrice, p.price)
        }
        let spacer = (maxPrice - minPrice)*0.1
        minPrice = max(0, minPrice - spacer)
        maxPrice = maxPrice + spacer
        
        // calc the layout
        calcLayout()
        
        // animate in the graph
        graphScale = 0
        createDisplayLink()
        setNeedsDisplay()
    }
    
    // ============================================================
    // ANIMATION
    // ============================================================
    // We use a display link at 30 frames per second to update the graph
    // and animate in the data series
    // just for effect
    
    weak var displayLink: CADisplayLink?
    
    func createDisplayLink() {
        self.displayLink?.invalidate() // cancel prior one, if any
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink(_:)))
        displayLink.add(to: .main, forMode: .common)
        self.displayLink = displayLink
    }
    
    // update the graph scale i.e. the percentage of the graph drawn
    // this is used to animate the length of the line (totalPoints * graph scale)
    // and also the y scale (so it powers up)
    @objc func handleDisplayLink(_ displayLink: CADisplayLink) {
        graphScale += 1/30
        
        if graphScale > 1{
            graphScale = 1
            displayLink.invalidate()
        }
        
        setNeedsDisplay()
    }
    // ============================================================
    // ============================================================
    
    // Whenever we are laid out we can recalculate our layout
    // that saves us having to do it in every draw cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        calcLayout()
        
    }
    // ============================================================
    // ============================================================
    
    // variables needed for laying out the graph
    
    var w:CGFloat = 0           // width
    var h:CGFloat = 0           // height
    var mx:CGFloat = 0          // marginx
    var my:CGFloat = 0          // marginy
    var deltap:CGFloat = 0      // space on x-axis between plot points
    var graphw:CGFloat = 0      // graph width
    var graphh:CGFloat = 0      // graph height
    
    var graphScale:CGFloat = 0  // scale to draw points to for animation
    
    // given the current size of the view workout the sizes for the graph
    // this gets called every time the graph is laid out (which shouldn't be
    // that often) and it saves us having to do these calculations in the
    // draw loop.
    // More things can be moved here when the graph design is finalised
    // so that only minimal calculation happens in the draw loop
    func calcLayout(){
        w = bounds.size.width
        h = bounds.size.height
        mx = w * 0.025
        my = h * 0.025
        graphw = w - 2*mx
        graphh = h-2*my
        
        deltap = graphw / CGFloat(prices.count)
    }
    // ============================================================
    // ============================================================
    
    // override the draw method so that we can draw the graph
    override func draw(_ rect: CGRect) {
        
        // keep it simple
        if let context = UIGraphicsGetCurrentContext(){
            
            // clear the background
            context.setFillColor(UIColor.white.cgColor)
            context.fill(rect)
            
            
            // draw some axis
            context.setStrokeColor(colorAxis)
            context.move(to: CGPoint(x: mx, y: h-my))
            context.addLine(to: CGPoint(x: w-mx, y: h-my))
            context.move(to: CGPoint(x: mx, y: h-my))
            context.addLine(to: CGPoint(x: mx, y: my))
            context.strokePath()
            
            // draw the points
            var sx:CGFloat = mx + 0
            let sy:CGFloat = h-my
            
            
            // draw grid lines
            let numGridLines = 10
            let gridh = graphh / CGFloat(numGridLines)
            
            context.setStrokeColor(colorGridlines)
            for i in 0 ..< numGridLines{
                let py = sy - gridh * CGFloat(i)
                context.move(to: CGPoint(x:sx, y:py))
                context.addLine(to: CGPoint(x:sx+graphw, y: py ))
            }
            context.strokePath()
            
            // draw the graph
            context.setStrokeColor(colorPlot)
            let target = Int(CGFloat(prices.count) * graphScale)
            for i in 0 ..< target{
                
                let p = prices[i]
                let py = sy-graphh * ((p.price-minPrice)/(maxPrice-minPrice)) * graphScale
                if i == 0{
                    context.move(to: CGPoint(x:sx, y:py))
                }else{
                    context.addLine(to: CGPoint(x:sx, y: py ))
                }
                sx += deltap
            }
            
            context.strokePath()
            
        }
        
    }
    // ============================================================
    // ============================================================
    
    // ============================================================
    // ============================================================
}
