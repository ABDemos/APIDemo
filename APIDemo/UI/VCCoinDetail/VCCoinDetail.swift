//
//  VCCoinDetail.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//


import UIKit

// Displays the detailed information for this coin
class VCCoinDetail: UIViewController {
    
    // ========================================================================================
    // Variables
    // ========================================================================================

    var coin:ObjCoin!

    // ========================================================================================
    // UI Components
    // ========================================================================================

    var viewCoinDetail:ViewCoinDetail!
    var spinner:UIActivityIndicatorView!
    
    // ========================================================================================
    // Initialise and allow us to pass the coin we are interested in
    // ========================================================================================
    convenience init(_ thisCoin:ObjCoin){
        self.init()
        self.coin = thisCoin
        
        // immediately ask for the coin history from the data object
        getCoinHistory()
    }
    
   
    // ========================================================================================
    // create the UI when we are first loaded
    // ========================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up navigation items and general features
        navigationItem.title = AppDelegate.AppTitle
        view.backgroundColor = AppStyle.colorBG
        
        // create the UI
        createUI()
        
    }
    
    // ========================================================================================
    // we create the coin detail view using our programmatic view builder
    // ========================================================================================
    func createUI(){
        viewCoinDetail = ViewCoinDetail()
        viewCoinDetail.alpha = 0
        viewCoinDetail.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewCoinDetail)
        viewCoinDetail.snapToView(view)
        
        // add a spinner while we load up
        spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // ========================================================================================
    // Updates
    // ========================================================================================

    // send off a request to get the coin price history so that we can draw a graph
    // this uses a callback instead of a notification to check when the data has been delivered (or not)
    func getCoinHistory(){
        
        AppDelegate.data.getCoinHistory(coin) { response, error in
            
            // check for an error
            if error != nil{
                self.bError = true
                
                // there was an error so we need to show an alert to the user on the main thread
                DispatchQueue.main.async {
                    self.showDataError(error: error)
                }
                return
            }
            
            // if we have data then we can show history
            if let prices = response as? [ObjPrice]{
                self.updateHistory(prices)
            }else{
                
            }
            
            
        }
    }
    
    // the API has come back with some data
    func updateHistory(_ newPrices:[ObjPrice]){

        // animate the screen in when we have some data
        UIView.animate(withDuration: 0.25) {
            self.viewCoinDetail.alpha = 1
            self.spinner.alpha = 0
        } completion: { bDone in
            self.spinner.stopAnimating()
            self.viewCoinDetail.alpha = 1
        }

        // update the view with the data
        viewCoinDetail.updateView(coin: coin, prices: newPrices)
    }
    
    // ========================================================================================
    // Error handling
    // ========================================================================================

    
    // if there is a problem with data then we need to show an error
    var bError:Bool = false
    
    func showDataError(error:Error?){

        // update the UI if there is an error - we don't want to see a half populated screen
        if bError{
            viewCoinDetail.isHidden = true
            self.spinner.stopAnimating()
        }
        
        // tell the user and let them decide what to do
        self.showConnectionAlert() {
            // try again

            // set up the UI correctly
            self.bError = false
            self.spinner.startAnimating()
            self.viewCoinDetail.alpha = 0
            self.viewCoinDetail.isHidden = false

            UIView.animate(withDuration: 0.25) {
                self.spinner.alpha = 1
            } completion: { bDone in
            }

            // make a call to the data object to get some more data
            self.getCoinHistory()
            
        } cancel: {
            // pop this view controller
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // ========================================================================================
    // ========================================================================================

    
}
