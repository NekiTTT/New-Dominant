//
//  DMAnalyticsViewController.swift
//  Dominant Investors
//
//  Created by Nekit on 19.02.17.
//  Copyright © 2017 Dominant. All rights reserved.
//

import UIKit
import MBProgressHUD

class DMAnalyticsViewController: DMViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var collectionHeight : NSLayoutConstraint!
    
    var companies        = [DMCompanyModel]()
    var inlineCellsCount : CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DMAPIService.sharedInstance.getAnalyticsCompanies { (companies) in
            DispatchQueue.main.async {
                self.companies = companies
                self.collectionView?.reloadData()
                MBProgressHUD.hide(for: self.view, animated: true)
                if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    self.resizeCollection(cellHeight: layout.itemSize.height, inlineCount: self.inlineCellsCount)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateCollectionViewLayout(with: size)
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func updateCollectionViewLayout(with size: CGSize) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
           
            if (size.width < size.height) {
                layout.itemSize = CGSize(width: size.width/2, height: size.width/2)
                self.inlineCellsCount = 2
            } else {
                layout.itemSize = CGSize(width: size.width/3, height: size.width/3)
                self.inlineCellsCount = 3
            }
            
            layout.sectionInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            self.resizeCollection(cellHeight: layout.itemSize.height, inlineCount: self.inlineCellsCount)
            layout.invalidateLayout()
            self.collectionView?.setCollectionViewLayout(layout, animated: true)
        }
    }
    
    // MARK: Private
    
    private func setupUI() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
        if (UIDevice.current.orientation == UIDeviceOrientation.portrait) {
            self.inlineCellsCount = 2
        }
    
        layout.itemSize = CGSize(width: screenWidth/inlineCellsCount, height: screenWidth/self.inlineCellsCount)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        self.collectionView?.setCollectionViewLayout(layout, animated: true)
        
        let cellNib = UINib.init(nibName: "DMCompanyCollectionCell", bundle: Bundle.main)
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier:"DMCompanyCollectionCell")
    }
    
    private func showCompanyDetail(company : DMCompanyModel) {
        let companyDetail = UIStoryboard(name: "Analytics", bundle: nil).instantiateViewController(withIdentifier: "DMCompanyDetailViewController") as! DMCompanyDetailViewController
        companyDetail.company = company
        self.navigationController?.pushViewController(companyDetail, animated: true)
    }
    
    private func resizeCollection(cellHeight : CGFloat, inlineCount : CGFloat) {
        self.collectionHeight.constant = ((CGFloat(self.companies.count) * CGFloat(cellHeight)) / inlineCount) - 20
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showCompanyDetail(company: companies[indexPath.row])
    }

    // MARK: UICollectonViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DMCompanyCollectionCell", for: indexPath) as! DMCompanyCollectionCell
        let company = self.companies[indexPath.row]
        cell.setupWith(model: company)
        return cell
    }

}
