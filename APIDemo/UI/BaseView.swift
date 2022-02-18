//
//  BaseView.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import UIKit

// This is a view class that includes stubs that make programmatic view creation more consistent

class BaseView: UIView {
    
    // ============================================================
    // Call our initialise function every time we create one of these views
    // this ensures all our functions are called
    // ============================================================
    init() {
        super.init(frame: .zero)
        initialise()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ============================================================
    // Do this every time we create a view
    // ============================================================
    func initialise(){
        setupView()
        configureViews()
        addSubviews()
        addConstraints()
    }
    
    
    // ============================================================
    // This is the point where you can initialise any base view stuff e.g. background color etc
    // ============================================================
    func setupView(){
        
    }
    
    // ============================================================
    // if any of the views need to be configured then you can do it here before adding
    // ============================================================
    func configureViews(){
        
    }
    
    // ============================================================
    // Add all the child views to our base view
    // ============================================================
    func addSubviews(){
        
    }
    
    // ============================================================
    // Set up inital constraints here
    // ============================================================
    func addConstraints(){
        
    }
    
    
    
    
}
