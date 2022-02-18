//
//  ViewController.swift
//  APIDemo
//
//  Created by Adam Beaumont on 16/02/2022.
//

import UIKit

// This is the main view controller
// It uses the programmatically created ViewMain to display its UI and then responds to delegate calls
// It communicates with the global data object to initiate data gets from the API
class VCMain: UIViewController , ViewMainDelegate{
    
    // ========================================================================================
    // Variables
    // ========================================================================================
    var viewMain:ViewMain!
    
    // ========================================================================================
    // Load the View
    // ========================================================================================

    // Create the view when the controller is first created
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set navigation
        navigationItem.title = AppDelegate.AppTitle
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.isTranslucent = false
        
        // view background color
        view.backgroundColor = AppStyle.colorBG
        
        // register for data refresh notification
        registerForNotifications()
        
        // create UI
        createUI()
        
    }
    
    
    // ========================================================================================
    // Create the UI
    // ========================================================================================
    
    private func createUI(){
        // add the main view
        viewMain = ViewMain()
        viewMain.delegate = self
        viewMain.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewMain)
        viewMain.snapToView(view)

    }

    // ========================================================================================
    // Handle delegate calls from our UI
    // ========================================================================================

    // when we select a coin we need to show the coin detail screen
    func selectCoin(thisCoin: ObjCoin) {
        let vc = VCCoinDetail(thisCoin)
        navigationController?.pushViewController(vc, animated: true)
    }

    // refresh the table view by just updating the global data object
    func refreshTableView() {
        AppDelegate.data.getCoins()
    }

    // ========================================================================================
    // Notifications from global data
    // ========================================================================================
    
    
    // register to get notifications if the data is updated
    func registerForNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefreshNotification), name: NSNotification.Name("dataRefresh"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleErrorNotification), name: NSNotification.Name("dataError"), object: nil)
        
    }
    
    // remove observers when we are destroyed
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // handle a refresh notification from the data object
    @objc func handleRefreshNotification(_ notification:Notification){
        
        // get rid of the refresh control
        viewMain.endRefreshing()
        
        // check that it is something we are interested in
        if let userInfo = notification.userInfo, let objects = userInfo["objects"] as? [String]{
            
            if objects.contains("coins"){
                // reload the data in the tableview
                viewMain.reloadData()
                return
            }
        }
    }
    
    // our attempt to get some data seems to have failed - let the user know
    @objc func handleErrorNotification(_ notification:Notification){
        DispatchQueue.main.async {
            
            self.showConnectionAlert() {
                AppDelegate.data.getCoins()
            } cancel: {
                // do nothing
            }
            
        }
    }
    
    // ========================================================================================
    // ========================================================================================
    // ========================================================================================
    
}

