//
//  BannerView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 25/02/2024.
//

import Foundation
import GoogleMobileAds
import UIKit
import SwiftUI

struct BannerView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = BannerAdViewController()
        viewController.view.backgroundColor = .clear
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

#Preview {
    BannerView()
}

struct BannerModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            BannerView()
                .frame(height: 60)
                .background(Color.clear) // Set background to clear
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

extension View {
    func addBanner() -> some View {
        self.modifier(BannerModifier())
    }
}


