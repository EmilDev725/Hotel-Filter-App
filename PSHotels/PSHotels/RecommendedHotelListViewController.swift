//
//  RecommendedHotelListViewController.swift
//  PSHotels
//
//  Created by Panacea-Soft on 2/11/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation
import GoogleMobileAds

class RecommendedHotelListViewController: PSUIViewController {
    
    // MARK: - Custom variables
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    @IBOutlet weak var recommendedListView: RecommendedListView!
    
    var bannerView: GADBannerView!
  
    
    //var adBannerView: GADBannerView?
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.selectedMenuIndex = 3
        
        bannerHeight.constant = 0.0
        
        // For Menu On/Off with Swipe
        super.initSWReveal(menuButton: menuButton)
        
        super.controllerTitle = language.menu__recommendedHotel
        
        recommendedListView.setup()
        
        setupAdmob()
        
    }
    
    // MARK: - Custom Functions
    func setupAdmob() {
        if admobConfig.isEnabled {
            bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            Common.instance.addBannerViewToView(bannerView, view: admobView)
            bannerView.adUnitID = admobConfig.bannerAdUnitId
            bannerView.rootViewController = self
            bannerView.delegate = self
            bannerView.load(GADRequest())
        }
    }
    
}

extension RecommendedHotelListViewController : GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Banner loaded successfully")
        bannerHeight.constant = 50.0
        
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Fail to receive ads")
        bannerHeight.constant = 0.0
        print(error)
    }
    
}
