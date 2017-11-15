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
    @IBOutlet weak var infoLabel        : UILabel!
    @IBOutlet weak var infoTextLabel    : UILabel!
    @IBOutlet weak var companyNameLabel : UILabel!
    @IBOutlet weak var getSignalsButton : UIButton!
    @IBOutlet weak var companyLogo      : UIImageView!
    @IBOutlet weak var chartContainer   : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadChart()
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

        fillCompanyData()
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
        
//        self.chartWebView.delegate = self
//        self.showActivityIndicator()
//
//        let HTMLString = String(format : "<!-- TradingView Widget BEGIN --> <script type=\"text/javascript\" src=\"https://s3.tradingview.com/tv.js\"></script> <script type=\"text/javascript\"> new TradingView.widget({ \"autosize\": true, \"symbol\": \"NASDAQ:AAPL\", \"interval\": \"D\", \"timezone\": \"Etc/UTC\", \"theme\": \"Dark\", \"style\": \"1\", \"locale\": \"ru\", \"toolbar_bg\": \"rgba(0, 0, 0, 1)\", \"enable_publishing\": false, \"hide_top_toolbar\": true, \"save_image\": false, \"hideideas\": true }); </script> <!-- TradingView Widget END -->")
//
//        self.chartWebView.loadHTMLString(HTMLString, baseURL: nil)
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
    
}
