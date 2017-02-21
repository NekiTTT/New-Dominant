//
//  DMDropdownViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMDropdownViewController: DMViewController {

    var dataSource          = [StockSearchResult]()
    var portfolioController : DMDropdownListDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DMDropDownTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "DMDropDownTableViewCell")
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        portfolioController = parent as! DMPortfolioViewController
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DMDropDownTableViewCell") as! DMDropDownTableViewCell
        cell.symbolLbl.text = dataSource[indexPath.row].symbol
        cell.nameLbl.text = dataSource[indexPath.row].name
        cell.currentPrice.text = dataSource[indexPath.row].assetType
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.portfolioController?.tickerDidSelected(stock: self.dataSource[indexPath.row])
    }

}
