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
    
    var ratings : [DMRatingModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        DMAPIService.sharedInstance.getUserRatings { (ratings) in
            DispatchQueue.main.async {
                self.ratings = ratings
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK : Private
    
    private func setupUI() {
       self.tableView.delegate = self
       self.tableView.register(DMRatingTableViewCell.self, forCellReuseIdentifier: "DMRatingCell")
    }

    // MARK : UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DMRatingCell") as! DMRatingTableViewCell
        cell.setupWith(model: ratings[indexPath.row])
        return cell
    }
    
}
