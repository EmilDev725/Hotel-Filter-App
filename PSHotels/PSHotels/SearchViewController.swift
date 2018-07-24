//
//  SearchViewController.swift
//
//  Created by Panacea-soft on 11/23/15.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import UIKit
import GoogleMobileAds

class SearchViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchViewContainer: SearchView!
    
    let reviewViewModel = ReviewViewModel()
    
    // MARK: Override Functions
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.psTitle
         searchViewContainer.parentView = self
        searchViewContainer.setup()
        
        appDelegate.selectedMenuIndex = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(openSupplierOffers), name: NSNotification.Name(rawValue: "PushToSupplierOffers"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openWeddingBlog), name: NSNotification.Name(rawValue: "pushToWeddingBlog"), object: nil)
    }
    
    @objc func openSupplierOffers() {
        self.performSegue(withIdentifier: "pushToSupplierOffers", sender: self)
    }
    
    @objc func openWeddingBlog() {
        self.performSegue(withIdentifier: "pushToWeddingBlog", sender: self)
    }
}


