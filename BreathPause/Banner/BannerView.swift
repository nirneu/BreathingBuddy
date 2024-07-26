//
//  BannerView.swift
//  BreathingBuddy
//
//  Created by Nir Neuman on 25/02/2024.
//

import SwiftUI
import GoogleMobileAds
import UIKit

struct BannerView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = BannerAdViewController()
        viewController.view.backgroundColor = .clear
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct BannerModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            VStack(spacing: 0) {
                content
            }
            VStack {
                Spacer() // Push the banner to the bottom
                BannerView()
                    .frame(height: 50)
                    .background(Color.clear)
            }
        }
//        .edgesIgnoringSafeArea(.bottom)
    }
}

extension View {
    func addBanner() -> some View {
        self.modifier(BannerModifier())
    }
}

#Preview {
    BannerView()
}
