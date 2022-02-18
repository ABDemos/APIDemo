//
//  AppStyle.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation
import UIKit

// ================================================================================
// Class responsible for holding all the styles for this app
// This is static for this app for the sake of convenience while developing
//
// This doesn't work so well if we wanted to split out views and make them reusable
// across projects.  In that case we would need a different model
// ================================================================================

class AppStyle{
    
    // ================================================================================
    // Colors
    // ================================================================================
    static let colorBG:UIColor = UIColor.darkGray
    static let colorDefaultText:UIColor = .white
    static let colorTextInverse:UIColor = .black
    
    static let colorTextUp:UIColor = UIColor(red: 100/255, green: 255/255, blue: 100/255, alpha: 1)
    static let colorTextDown:UIColor = UIColor(red: 255/255, green: 125/255, blue: 125/255, alpha: 1)
    static let colorChange:UIColor = .black
    static let colorTextTableViewHeader:UIColor = .white
    static let colorTableViewSeparator:UIColor = .lightGray
    static let colorTableViewHeaderBG:UIColor = UIColor.lightGray
    
    // ================================================================================
    // Fonts
    // ================================================================================
    static let fontDefault:UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    static let fontTableViewCell:UIFont = UIFont.systemFont(ofSize: 12)
    static let fontTableViewCellPrice:UIFont = UIFont.systemFont(ofSize: 14)
    static let fontTableViewCellChange:UIFont = UIFont.systemFont(ofSize: 14)
    static let fontTableViewCellMedium:UIFont = UIFont.systemFont(ofSize: 16)
    static let fontTableViewCellBold:UIFont = UIFont.boldSystemFont(ofSize: 12)
    
    static let fontTableViewCellSmall:UIFont = UIFont.systemFont(ofSize: 10)
    static let fontTableViewHeader:UIFont = UIFont.boldSystemFont(ofSize: 14)
    
    static let fontTitleLarge:UIFont = UIFont.boldSystemFont(ofSize: 30)
    static let fontTitle:UIFont = UIFont.boldSystemFont(ofSize: 24)
    
    static let fontPriceHistoryHeader:UIFont = UIFont.boldSystemFont(ofSize: 18)
    static let fontPriceHistory:UIFont = UIFont.boldSystemFont(ofSize: 14)
    
    static let fontPriceLarge:UIFont = UIFont.boldSystemFont(ofSize: 18)
    
    // ================================================================================
    // Values
    // ================================================================================
    static let heightTableViewHeader:CGFloat = 44
    static let heightTableViewRow:CGFloat = 64
    
    static let heightButton:CGFloat = 44
    static let heightBlock:CGFloat = 44
    
    static let heightTextline:CGFloat = 32
    
    static let gap:CGFloat = 8
    static let gapBig:CGFloat = 24
    static let textMarginX:CGFloat = 8
    
    static let cornerRadius:CGFloat = 8
    
    // ================================================================================
    // Columns
    // ================================================================================
    // these are the column widths we are going to use
    static let multiplierCol1:CGFloat = 0.125
    static let multiplierCol2:CGFloat = 0.4
    static let multiplierCol3:CGFloat = 0.2
    static let multiplierCol4:CGFloat = 0.2
    
    // ================================================================================
    // Formatter helper functions
    // ================================================================================
    static func formatCurrency(value:Double, dp:Int = 2)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = dp
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
    static func formatNumber(value:Double, dp:Int = 2)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = dp
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
