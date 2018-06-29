//
//  ReviewRoomFilterViewController.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/9/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation
import GoogleMobileAds

class ReviewRoomFilterViewController: PSUIViewController {
    
    // MARK: - Custom variables
    
    var bannerView: GADBannerView!
    
    @IBOutlet weak var reviewRoomFilterView: ReviewRoomFilterView!
    
    
    @IBOutlet weak var admobView: UIView!
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    var delegate : RoomFilterViewProtocol? = nil
    var hotelData: Hotel? = nil
    // MARK: Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controllerTitle = language.reviewRoomFilter
        
        reviewRoomFilterView.hotelData = hotelData
        reviewRoomFilterView.delegate = self.delegate
        reviewRoomFilterView.parent = self
        reviewRoomFilterView.setup()
        
        PSNavigationController.instance.updateBackButton()
       
        
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


extension ReviewRoomFilterViewController : GADBannerViewDelegate {
    
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
