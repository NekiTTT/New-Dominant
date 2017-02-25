//
//  DMRotatingViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 25.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMRotatingViewController: DMViewController {

    var viewControllers : [UIViewController]!
    var buttons         = [UIButton]()
    var containers      : [UIView]!
    var loaded          = false
    
    let tabIcons    = [UIImage(named: "analytic"), UIImage(named: "folio"), UIImage(named: "ideas")]
    let activeIcons = [UIImage(named: "analytic_active"), UIImage(named: "folio_active"), UIImage(named: "ideas_active")]
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var analyticsContainer : UIView!
    @IBOutlet weak var portfolioContainer : UIView!
    @IBOutlet weak var ratingsContainer   : UIView!
    
    @IBOutlet weak var stackView          : UIStackView!
    
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (!loaded) {
            setupControllers()
            setupContainers()
            setupTabButtons()
            showDefaultPage()
            loaded = true
        }
    }
    

    // MARK: Private
    private func setupTabButtons() {
        for index in 0...self.viewControllers.count - 1 {
            let newButton = UIButton()
            newButton.setImage(tabIcons[index], for: .normal)
            newButton.imageView?.contentMode = .scaleAspectFill
            newButton.tag = index
            newButton.addTarget(self, action: #selector(showTab(_:)), for: .touchUpInside)
            buttons.append(newButton)
            stackView.addArrangedSubview(newButton)
        }
    }
    
    private func setupContainers() {
        self.containers = [self.analyticsContainer, self.portfolioContainer, self.ratingsContainer]
    }
    
    private func setupControllers() {
        let analytic_controller  = UIStoryboard.init(name: "Analytics", bundle: Bundle.main).instantiateInitialViewController()
        let portfolio_controller = UIStoryboard.init(name: "Portfolio", bundle: Bundle.main).instantiateInitialViewController()
        let ratings_controller   = UIStoryboard.init(name: "Ratings"  , bundle: Bundle.main).instantiateInitialViewController()
        
        self.viewControllers = [analytic_controller!, portfolio_controller!, ratings_controller!]
    }
    
    private func showDefaultPage() {
        self.showTab(index: Values.DMDefaultScreen)
    }
    
    private func showTab(index : Int) {
        self.view.bringSubview(toFront: containers[index])
    }
    
    // MARK: Actions
    
    @objc private func showTab(_ sender : UIButton) {
        showTab(index: sender.tag)
        for button in buttons { button.setImage(tabIcons[button.tag], for: .normal) }
        sender.setImage(activeIcons[sender.tag], for: .normal)
    }

}
