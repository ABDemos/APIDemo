//
//  AlertConnectionError.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//
import Foundation
import UIKit


extension UIViewController{
    
    // helper function to show a connection alert with the option to try again or cancel the operation
    func showConnectionAlert(tryAgain: @escaping(()->Void), cancel: @escaping(()->Void), msg:String? = nil){
        
        let thisMessage = msg ?? "Unable to get data from the internet.\n\nCheck your network connection and try again..."
        
        let alert = UIAlertController(title: "Connection Error", message: thisMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Try again...", style: UIAlertAction.Style.default, handler: { alert in
            tryAgain()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { alert in
            cancel()
        }))
        
        present(alert, animated: true) {
            // shown it
        }
    }
    
    
}
