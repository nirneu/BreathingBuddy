import UIKit
import GoogleMobileAds
import SwiftUI
import AppTrackingTransparency

class BannerAdViewController: UIViewController, GADBannerViewDelegate {
    var bannerView: GADBannerView?
    let adUnitId = "ca-app-pub-3367927715135195/3849911755"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBannerView()
        configureAndLoadAds()
    }
    
    private func setupBannerView() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView?.adUnitID = adUnitId
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        
        let bannerWidth = view.frame.size.width
        bannerView?.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(bannerWidth)
        
        setAdView(bannerView!)
    }
    
    private func configureAndLoadAds() {
        let request = GADRequest()
        request.scene = view.window?.windowScene
        
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                loadBannerAd()
            default:
                loadBannerAdWithoutTracking()
            }
        }
        bannerView?.load(request)
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
    
    func setAdView(_ view: GADBannerView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
