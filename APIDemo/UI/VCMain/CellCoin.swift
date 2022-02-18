//
//  CellCoin.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import UIKit

// Display the row for a CryptoCurrency in the main tableview
class CellCoin: UITableViewCell {
    
    // ========================================================================================
    // UI Components
    // ========================================================================================
    var viewCoinRow:ViewCoinRow!
    
    // ========================================================================================
    // initialise this cell
    // ========================================================================================
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        // set the background color of this cell
        contentView.backgroundColor = AppStyle.colorBG
        
        // create the view that will handle displaying this row
        viewCoinRow = ViewCoinRow()
        viewCoinRow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(viewCoinRow)
        viewCoinRow.snapToView(contentView)
        
    }
    // ========================================================================================
    // update this cell with the details of this coin
    // ========================================================================================
    func setCoin(_ thisCoin:ObjCoin){
        viewCoinRow.updateView(thisCoin)
    }

    // ========================================================================================
    // Required
    // ========================================================================================
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // ========================================================================================
    // ========================================================================================

}
