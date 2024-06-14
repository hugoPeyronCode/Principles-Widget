//
//  PrincipleSelectionView.swift
//  Principles Widget
//
//  Created by Hugo Peyron on 14/06/2024.
//

import SwiftUI

struct TikTokSwipingBehavior: View {
    
    @State private var principles = [
        "Choose the right moments to give your opinion.",
        "Respect everyone.",
        "Do not criticize behind someone's back.",
        "Be honest but not hurtful.",
        "Always Tell the truth.",
        "Take care of your family.",
        "Listen to your intuition.",
        "Take risks.",
        "Practice empathy and understanding.",
        "Value your time and the time of others.",
        "Keep learning and stay curious.",
        "Stay humble and open-minded.",
        "Be grateful and express gratitude regularly.",
        "Prioritize your health and well-being.",
        "Set and pursue meaningful goals.",
        "Practice forgiveness and let go of grudges.",
        "Surround yourself with positive and supportive people.",
        "Give back to your community.",
        "Stay true to your values and principles.",
        "Find joy in the small things."
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(principles, id: \.self) { principle in
                    ZStack {
                        Rectangle()
                            .background(.thickMaterial)
                            .containerRelativeFrame([.horizontal, .vertical])
                        Text(principle)
                            .font(.title2)
                            .bold()
                            .fontDesign(.monospaced)
                            .padding()
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
    }
}

#Preview {
    TikTokSwipingBehavior()
}
