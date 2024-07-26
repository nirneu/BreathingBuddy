//
//  InfoView.swift
//  BreathPause
//
//  Created by Nir Neuman on 21/07/2024.
//

import SwiftUI

struct InfoView: View {
    let infoText: String
    @Environment(\.dismiss) var dismiss
    
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
                    .padding()
                
                Spacer()
                
                Button("Close") {
                    dismiss()
                }
                .font(.headline)
                .padding()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
  InfoView(infoText: "Demo Text")
}
