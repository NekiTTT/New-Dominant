//
//  DMSignalsViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMSignalsViewController: DMViewController, UITableViewDataSource, UITableViewDelegate, DMContainerDelegate {
   
    @IBOutlet weak var tableView             : UITableView!
    @IBOutlet weak var subscriptionContainer : UIView!
    
    var signals = [DMInvestmentSignalModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "contanerSegue" {
            let description = segue.destination as! DMSubscriptionViewController
            description.delegate = self
        }
    }
    
    // MARK: Private
    
    private func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(DMSignalCell.self, forCellReuseIdentifier: "DMSignalCell")
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DMSignalCell") as! DMSignalCell
        cell.setupWith(model: signals[indexPath.row])
        return cell
    }
    
    // MARK: DMContainerDelegate
    
    internal func hideContainer() {    
        self.subscriptionContainer.isHidden = true
        DMAPIService.sharedInstance.getInvestmentSignals { (signals) in
            DispatchQueue.main.async {
                self.signals = signals
                self.tableView.reloadData()
            }
        }
    }
    
    internal func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
