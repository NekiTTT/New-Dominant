//
//  DMEstimazeChartViewController.swift
//  Dominant Investors
//
//  Created by ios_nikitos on 19.11.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMEstimazeChartViewController: DMViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var ticker : String!
    
    //MARK: ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.ticker!
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let html = "<!doctype html><html lang=\"en\"> <head> <meta charset=\"utf-8\"><title>The HTML5 Herald</title> <meta name=\"description\" content=\"The HTML5 Herald\"> <meta name=\"author\" content=\"SitePoint\"><link rel=\"stylesheet\" href=\"css/styles.css?v=1.0\"><!--[if lt IE 9]> <script src=\"https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js\"></script> <![endif]--> </head><body><a href='http://www.estimize.com/aapl/fq1-2018?utm_medium=chart_share&utm_source=release_page#chart=historical'><img src='https://s3.amazonaws.com/com.estimize/charts/estimize-aapl-fq1-2018-6ea0e9ad42e0986f.png' width='665' height='620' /></a></body> </html>"
        
        self.webView.delegate = self
        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let bodyStyleVertical = "document.getElementsByTagName('body')[0].style.verticalAlign = 'middle';";
        let bodyStyleHorizontal = "document.getElementsByTagName('body')[0].style.textAlign = 'center';";
        let mapStyle = "document.getElementById('mapid').style.margin = 'auto';";
        
        self.webView.stringByEvaluatingJavaScript(from: bodyStyleVertical)
        self.webView.stringByEvaluatingJavaScript(from: bodyStyleHorizontal)
        self.webView.stringByEvaluatingJavaScript(from: mapStyle)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error.localizedDescription)
    }
    

}
