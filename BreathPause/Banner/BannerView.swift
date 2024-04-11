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

struct BannerView: UIViewControllerRepresentable{

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = BannerAdViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
#Preview {
    BannerView()
}

struct BannerModifier: ViewModifier {
    private let backgroundColor = Color(red: 0.9, green: 0.95, blue: 0.98)

    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            BannerView()
                .frame(height: 60)
                .background(backgroundColor)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

extension View {
    func addBanner() -> some View {
        self.modifier(BannerModifier())
    }
}

