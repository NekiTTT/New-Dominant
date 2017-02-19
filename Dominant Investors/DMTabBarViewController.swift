//
//  DMTabBarViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit

class DMTabBarViewController: DMViewController {

    var viewControllers : [UIViewController]!
    var containers      = [UIView]()
    
    // MARK: Outlets
    @IBOutlet weak var tabContainer : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK : Private
    
    private func setupUI() {
        let analytics = UIStoryboard(name: "Analytics", bundle: nil).instantiateInitialViewController()!
        let portfolio = UIStoryboard(name: "Portfolio", bundle: nil).instantiateInitialViewController()!
        let ratings   = UIStoryboard(name: "Ratings"  , bundle: nil).instantiateInitialViewController()!
        
        self.viewControllers = [analytics,portfolio,ratings]
        setupContainers()
    }
    
    private func setupContainers() {
        for index in 0...self.viewControllers.count - 1 {
            createContainer(index: index)
            addTab(tabIndex: index, controller: self.viewControllers[index])
        }
    }
    
    private func addTab(tabIndex : Int, controller : UIViewController) {
        
        let container = containers[tabIndex]
        addChildViewController(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: container.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])
        
        controller.didMove(toParentViewController: self)
    }
    
    private func createContainer(index : Int) {
        let container = UIView(frame: self.tabContainer.frame)
        containers.append(container)
    }
    
    private func showTab(index : Int) {
        self.view.bringSubview(toFront: containers[index])
    }

    // MARK : Actions
    
    @IBAction func showTab(sender : UIButton) {
        showTab(index: sender.tag)
    }
    
}
