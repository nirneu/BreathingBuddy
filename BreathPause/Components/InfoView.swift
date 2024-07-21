//
//  InfoView.swift
//  BreathPause
//
//  Created by Nir Neuman on 21/07/2024.
//

import SwiftUI

struct InfoView: View {
    let infoText: String
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Constants.gradientStart, Constants.gradientEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("Exercise Information")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text(infoText)
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                Button("Close") {
                    // Dismiss the view
                }
                .font(.headline)
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
  InfoView(infoText: "Demo Text")
}
