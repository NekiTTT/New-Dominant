//
//  DMRatingsViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMRatingsViewController: DMViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    var ratings = [DMRatingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DMAPIService.sharedInstance.getUserRatings { (ratings) in
            DispatchQueue.main.async {
                self.ratings = ratings.sorted(by: {$0.totalValue > $1.totalValue})
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Private
    
    private func setupUI() {
       self.tableView.dataSource = self
       self.tableView.delegate = self
       self.tableView.register(UINib(nibName: "DMRatingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "DMRatingTableViewCell")
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DMRatingTableViewCell") as! DMRatingTableViewCell
        let rateModel = ratings[indexPath.row]
        rateModel.position = indexPath.row + 1
        cell.setupWith(model: ratings[indexPath.row])
        return cell
    }
    
}
