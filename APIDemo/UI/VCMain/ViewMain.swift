//
//  ViewMain.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import Foundation
import UIKit

// protocol for out delegate to respond to events in the view
protocol ViewMainDelegate{
    func refreshTableView()
    func selectCoin(thisCoin:ObjCoin)
}

// View class for the main screen
class ViewMain: BaseView, UITableViewDelegate, UITableViewDataSource{
    
    var delegate:ViewMainDelegate? = nil
    
    // ============================================================================================================
    // view properties
    // ============================================================================================================
    override func setupView() {
        // set the header background
        backgroundColor = AppStyle.colorBG
    }

    override func configureViews() {
        // make sure the tableview knows where to get its data from
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = txtEmpty
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleDragToRefresh), for: .valueChanged)

    }
    
    // ============================================================================================================
    // Create the controls used in this view
    // ============================================================================================================
    // list to display all the coins
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CellCoin.self, forCellReuseIdentifier: AppDelegate.CELL_COIN)
        tableView.backgroundColor = .clear
        tableView.rowHeight = AppStyle.heightTableViewRow
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorColor = AppStyle.colorTableViewSeparator
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView

    }()
   
    // text to show if the list is empty
    private let txtEmpty:UILabel = {
        let txtEmpty = UILabel()
        txtEmpty.text = "No data available"
        txtEmpty.textAlignment = .center
        txtEmpty.textColor = AppStyle.colorDefaultText
        return txtEmpty
    }()
    
    // add a refresh control
    private let refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let t = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        refreshControl.attributedTitle = t
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    
    // ============================================================================================================
    // add subviews
    // ============================================================================================================
    override func addSubviews() {
        addSubview(tableView)
    }
    // ============================================================================================================
    // add the constraints
    // ============================================================================================================
    // programmatically set up constraints
    override func addConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
    
    // ============================================================================================================
    // Updates
    // ============================================================================================================
    // do this when you want to refresh
    @objc func handleDragToRefresh(sender:UIRefreshControl){
        delegate?.refreshTableView()
    }
    
    // stop the refresh control from spinning
    func endRefreshing(){
        tableView.refreshControl?.endRefreshing()
    }

    // We need to reload the list
    func reloadData(){
        tableView.reloadData()

    }
    
    // ============================================================================================================
    // table view callbacks
    // ============================================================================================================
    
    // how many rows are there in the table?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // if there are no rows then show the no data text
        if section == 0{
            if AppDelegate.data.coins.count == 0{
                tableView.backgroundView?.isHidden = false
            }else{
                tableView.backgroundView?.isHidden = true
            }
            return AppDelegate.data.coins.count
        }
        return 0
    }
    
    // get a cell for this indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppDelegate.CELL_COIN, for: indexPath) as! CellCoin
        cell.setCoin(AppDelegate.data.coins[indexPath.row])
        return cell
    }
    
    // we need a headerview
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return AppStyle.heightTableViewHeader
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ViewCoinHeader()
    }
    
    // When the user selects a row we can tell our delegate to do something about it
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let thisCoin = AppDelegate.data.coins[indexPath.row]
        delegate?.selectCoin(thisCoin: thisCoin)
    }
    // ========================================================================================
    // ========================================================================================
    
}
