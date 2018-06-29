//
//  HotelViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class HotelViewController: PSUIViewController {
    
    // MARK: - Custom variables
    
    var bannerView: GADBannerView!
    var hotelData : Hotel? = nil
    
    @IBOutlet weak var hotelView: HotelView!
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    var delegate: HotelViewDelegate? = nil
    
    // MARK: Override Functions

    
    override func viewDidLoad() {
        super.viewDidLoad()

        controllerTitle = (hotelData?.hotel_name)!
        
        hotelView.hotelData = hotelData
        hotelView.delegate = delegate
        hotelView.setup()
        
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


extension HotelViewController : GADBannerViewDelegate {
    
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
