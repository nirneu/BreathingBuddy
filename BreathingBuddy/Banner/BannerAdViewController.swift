//
//  BannerAdViewController.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 25/02/2024.
//

import Foundation
import GoogleMobileAds
import UIKit
import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class BannerAdViewController:UIViewController, GADBannerViewDelegate{
    var bannerView:GADBannerView?
    let adUnitId = "ca-app-pub-3367927715135195/3849911755"
    
    
    // View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkTrackingAuthorization()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            guard let self = self else {return}
            self.loadBannerAd()
        }
    }
    
    private func checkTrackingAuthorization() {
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    // Tracking authorization granted, load the ad normally
                    self.loadBannerAd()
                case .denied, .notDetermined, .restricted:
                    // Tracking authorization denied or not determined, loading a non-personalized
                    self.loadBannerAdWithoutTracking()
                @unknown default:
                    // Handle future cases
                    self.loadBannerAdWithoutTracking()
                }
            }
        }
    }
    
    private func loadBannerAd(){
        // adding Unit Id
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView?.adUnitID = adUnitId
        
        // make this root and set delegate
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        
        // setting banner size
        let bannerWidth = view.frame.size.width
        bannerView?.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(bannerWidth)
        
        let request = GADRequest()
        request.scene = view.window?.windowScene
        bannerView?.load(request)
        
        setAdView(bannerView!)
    }
    
    private func loadBannerAdWithoutTracking() {
        // Setup banner view without tracking
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView?.adUnitID = adUnitId
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        
        // setting banner size
        let bannerWidth = view.frame.size.width
        bannerView?.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(bannerWidth)
        
        // Create a GADRequest and configure it for non-personalized ads
        let request = GADRequest()
        request.scene = view.window?.windowScene
        // Configure the ad request for non-personalized ads
        let extras = GADExtras()
        extras.additionalParameters = ["npa": "1"]
        request.register(extras)
        
        bannerView?.load(request)
        setAdView(bannerView!)
    }
    
    func setAdView(_ view: GADBannerView){
        bannerView = view
        self.view.addSubview(bannerView!)
        bannerView?.translatesAutoresizingMaskIntoConstraints = false
        let viewDictionary:[String:Any] = ["_bannerView" : bannerView]
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[_bannerView]|", metrics: nil, views: viewDictionary)
        )
        
        self.view.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[_bannerView]|", metrics: nil, views: viewDictionary)
        )
    }
}
