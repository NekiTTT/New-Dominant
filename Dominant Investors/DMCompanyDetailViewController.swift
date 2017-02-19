//
//  DMCompanyDetailViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit
import Alamofire

class DMCompanyDetailViewController: DMViewController, ChartViewDelegate {

    var company   : DMCompanyModel!
    var chartView : ChartView!
    var chart     : SwiftStockChart!
    
    // MARK: Outlets
    @IBOutlet weak var infoLabel        : UILabel!
    @IBOutlet weak var infoTextLabel    : UILabel!
    @IBOutlet weak var companyNameLabel : UILabel!
    @IBOutlet weak var getSignalsButton : UIButton!
    @IBOutlet weak var companyLogo      : UIImageView!
    @IBOutlet weak var chartContainer   : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK : Private
    
    private func setupUI() {
        self.infoLabel.text        = self.company!.companyDescription
        self.companyLogo.image     = UIImage()
        self.companyNameLabel.text = self.company.name
        loadChart()
    }
    
    private func loadChart() {
        
        chartView = ChartView.create()
        chartView.delegate = self
        chartView.frame = CGRect(x: 10, y: 0, width: self.view.frame.size.width-20, height : self.chartContainer.frame.size.height)
        chartContainer.addSubview(chartView)
        
        chart = SwiftStockChart(frame: CGRect( x      : 5,
                                               y      : self.chartContainer.frame.size.height * 0.1,
                                               width  : self.view.frame.size.width - 10,
                                               height :   self.chartContainer.frame.size.height * 0.8 - (chartView.btnIndicatorView.frame.size.height + 5)))
        
        chartView.backgroundColor = UIColor.clear
        
        chart.axisColor = UIColor.red
        chart.verticalGridStep = 5
        chart.horizontalGridStep = 5
        
        chartView.addSubview(chart)
        chartView.backgroundColor = UIColor.black
        loadChartWithRange(range: .OneDay)
        self.navigationController!.navigationBar.barStyle = .blackTranslucent
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()

    }
    
    // MARK : ChartViewDelegate
    
    func loadChartWithRange(range: ChartTimeRange) {
        
        chart.timeRange = range
        
        let times = chart.timeLabelsForTimeFrame(range: range)
        chart.horizontalGridStep = times.count - 1
        
        chart.labelForIndex = {(index: NSInteger) -> String in
            return times[index]
        }
        
        chart.labelForValue = {(value: CGFloat) -> String in
            return String(format: "%.02f", value)
        }
        
        SwiftStockKit.fetchChartPoints(symbol: self.company.ticker, range: range) { (chartPoints) -> () in
            self.chart.clearChartData()
            self.chart.setChartPoints(points: chartPoints)
        }
    }
    
    func didChangeTimeRange(range: ChartTimeRange) {
        loadChartWithRange(range: range)
    }

    // MARK : Actions
    
    @IBAction func showSignals(sender : UIButton) {
        let signals = UIStoryboard(name: "Signals", bundle: nil).instantiateInitialViewController()
        self.present(signals!, animated: false, completion: nil)
    }
    
}
