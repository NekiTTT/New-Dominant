//
//  DMCompanyDetailViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit
import Alamofire

class DMCompanyDetailViewController: DMViewController, ChartViewDelegate, UIWebViewDelegate {

    var company   : DMCompanyModel!
    var chartView : ChartView? = nil
    var chart     : SwiftStockChart!
    
    // MARK: Outlets
    @IBOutlet weak var infoLabel         : UILabel!
    @IBOutlet weak var infoTextLabel     : UILabel!
    @IBOutlet weak var companyNameLabel  : UILabel!
    @IBOutlet weak var getSignalsButton  : UIButton!
    @IBOutlet weak var estimizeButton    : UIButton!
    @IBOutlet weak var tradingViewButton : UIButton!
    @IBOutlet weak var companyLogo       : UIImageView!
    @IBOutlet weak var chartContainer    : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        for view in self.chartContainer.subviews {
            view.removeFromSuperview()
        }
        coordinator.animate(alongsideTransition: { context in
            context.viewController(forKey: UITransitionContextViewControllerKey.from)
        }, completion: { context in
            self.loadChart()
        })
    }
    
    // MARK: Private
    
    private func setupUI() {
        self.infoLabel.text        = self.company!.companyDescription
        self.companyLogo.image     = UIImage()
        self.companyNameLabel.text = self.company.name
        
        if self.company.estimazeURL == nil {
            self.estimizeButton.isEnabled = false
            self.estimizeButton.alpha = 0.5
        }

        fillCompanyData()
        
        self.estimizeButton.layer.cornerRadius = 20.0
        self.estimizeButton.layer.borderColor = UIColor.red.cgColor
        self.estimizeButton.layer.borderWidth = 1.0
        
        self.tradingViewButton.layer.cornerRadius = 20.0
        self.tradingViewButton.layer.borderColor = UIColor.red.cgColor
        self.tradingViewButton.layer.borderWidth = 1.0
    }
    
    private func fillCompanyData() {
        
        DMAPIService.sharedInstance.downloadCompanyLogoWith(ID: company.id) { (image) in
            DispatchQueue.main.async {
                self.companyLogo.image = image
            }
        }
        
        var annualSales_String = "Target Price "
        annualSales_String = annualSales_String.appending(company.targetPrice)
        annualSales_String = annualSales_String.appending("\n")
        
        let annualSales_atributed = NSMutableAttributedString(string: annualSales_String)
        annualSales_atributed.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: infoLabel.font.pointSize), range: NSRange(location:13,length:annualSales_atributed.length - 13))
        
        
        var IPO_String = "Buy Point "
        IPO_String = IPO_String.appending(company.buyPoint)
        IPO_String = IPO_String.appending("\n")
        
        let IPO_atributed = NSMutableAttributedString(string: IPO_String)
        IPO_atributed.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: infoLabel.font.pointSize), range: NSRange(location:10,length:IPO_atributed.length-10))
        
        var averageSales_String = "Investment horizon "
        averageSales_String = averageSales_String.appending(company.investmentHorizon)
        averageSales_String = averageSales_String.appending("\n")
        
        let averageSales_atributed = NSMutableAttributedString(string: averageSales_String)
        averageSales_atributed.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: infoLabel.font.pointSize), range: NSRange(location:19,length:averageSales_atributed.length - 19))
        
        
        var marketCapitalization_string = "Stop-Loss "
        marketCapitalization_string = marketCapitalization_string.appending(company.stopLoss)
        marketCapitalization_string = marketCapitalization_string.appending("\n")
        
        let marketCapitalization_atributed = NSMutableAttributedString(string: marketCapitalization_string)
        marketCapitalization_atributed.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: infoLabel.font.pointSize), range: NSRange(location:10,length:marketCapitalization_atributed.length - 10))
        
        let potential_string = "Potential profitability " + company.potentialProfitability
        let potential_string_atributed = NSMutableAttributedString(string: potential_string)
        potential_string_atributed.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: infoLabel.font.pointSize), range: NSRange(location:24 ,length: potential_string_atributed.length - 24))
        
        annualSales_atributed.append(IPO_atributed)
        annualSales_atributed.append(marketCapitalization_atributed)
        annualSales_atributed.append(averageSales_atributed)
        annualSales_atributed.append(potential_string_atributed)
        
        infoTextLabel.attributedText = annualSales_atributed

    }
    
    
    private func loadChart() {
        
        chartView = ChartView.create()
        chartView?.delegate = self
        chartView?.frame = CGRect(x: 24, y: 0, width: self.chartContainer.frame.width-48, height: self.chartContainer.frame.height)
        chartContainer?.addSubview(chartView!)

        chart = SwiftStockChart(frame: CGRect(x : 16, y :  10, width : self.chartContainer.bounds.size.width - 60, height : chartContainer.frame.height - 80))

        chartView?.backgroundColor = UIColor.clear

        chart.axisColor = UIColor.red
        chart.verticalGridStep = 3

        loadChartWithRange(range: .OneDay)

        chartView?.addSubview(chart)
        chartView?.backgroundColor = UIColor.black


        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    
    // MARK: ChartViewDelegate
    
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

    // MARK: Actions
    
    @IBAction func showSignals(sender : UIButton) {
        self.performSegue(withIdentifier: "DMSignalsSegue", sender: self)
    }
    
    @IBAction func backButtonAction(sender : UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func estimazeButtonPressed(sender : UIButton) {
        guard let estimazeURL = self.company.estimazeURL else { return }
        
       
        let storyboard = UIStoryboard.init(name: "Сharts", bundle: nil)
        if let chartVC = storyboard.instantiateViewController(withIdentifier: "DMEstimazeChartViewController") as? DMEstimazeChartViewController {
            chartVC.estimazeImageURL = estimazeURL
            chartVC.ticker = self.company.ticker
            self.showChart(chart: chartVC)
        }
    }
    
    @IBAction func tradingViewChartButtonPressed(sender : UIButton) {
        let storyboard = UIStoryboard.init(name: "Сharts", bundle: nil)
        if let chartVC = storyboard.instantiateViewController(withIdentifier: "DMTradingViewChartViewController") as? DMTradingViewChartViewController {
            chartVC.ticker = self.company.ticker
            self.showChart(chart: chartVC)
        }
    }
    
    fileprivate func showChart(chart : UIViewController) {
        
        self.navigationController?.pushViewController(chart, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let backItem = UIBarButtonItem()
            backItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 16/255, green: 18/255, blue: 26/255, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
    }

}




