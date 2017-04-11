//
//  DMWatchListService.swift
//  Dominant Investors
//
//  Created by Nekit on 09.04.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMWatchListService: NSObject, UITableViewDataSource, UITableViewDelegate {

    
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: UITableViewDelegate
    
}
