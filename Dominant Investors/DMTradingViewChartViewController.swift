//
//  DMTradingViewChartViewController.swift
//  Dominant Investors
//
//  Created by ios_nikitos on 25.09.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit
import WebKit

class DMTradingViewChartViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let html = "<!doctype html><html lang=\"en\"> <head> <meta charset=\"utf-8\"><title>The HTML5 Herald</title> <meta name=\"description\" content=\"The HTML5 Herald\"> <meta name=\"author\" content=\"SitePoint\"><link rel=\"stylesheet\" href=\"css/styles.css?v=1.0\"><!--[if lt IE 9]> <script src=\"https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js\"></script> <![endif]--> </head><body> <!-- TradingView Widget BEGIN --> <script type=\"text/javascript\" src=\"https://s3.tradingview.com/tv.js\"></script> <script type=\"text/javascript\"> new TradingView.widget({ \"width\": 980, \"height\": 610, \"symbol\": \"NASDAQ:AAPL\", \"interval\": \"D\", \"timezone\": \"Etc/UTC\", \"theme\": \"Dark\", \"style\": \"1\", \"locale\": \"ru\", \"toolbar_bg\": \"#f1f3f6\", \"enable_publishing\": false, \"allow_symbol_change\": true, \"hideideas\": true }); </script> <!-- TradingView Widget END --> </body> </html>"
        self.webView.scalesPageToFit = true
        self.webView.contentMode = .scaleAspectFit
        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
    
    }

}
