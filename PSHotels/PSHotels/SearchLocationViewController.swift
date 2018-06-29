//
//  SearchLocationViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/23/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class SearchLocationViewController: PSUIViewController {
    
    // MARK: - Custom variables
    @IBOutlet weak var searchLocationView: SearchLocationView!
    var bannerView: GADBannerView!
    
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    var delegate : SearchLocationProtocol? = nil
    
    // MARK: Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = "Select Supplier"
        
        searchLocationView.delegate = self.delegate
        searchLocationView.parent = self
        searchLocationView.setup()
        
        PSNavigationController.instance.updateBackButton()
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    
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


extension SearchLocationViewController : GADBannerViewDelegate {
    
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
