//
//  CircularProgressBar.swift
//  Principles Widget
//
//  Created by Hugo Peyron on 14/06/2024.

import SwiftUI

struct CircularProgressBar: View {
    let progress: Double
    let color : Color
    let fontSize: Font
    let lineWidth : CGFloat
    let withText : Bool
    let image: String
    
    init(progress: Double, color: Color, lineWidth: CGFloat, image: String) {
        self.progress = progress
        self.color = color
        self.fontSize = .largeTitle
        self.lineWidth = lineWidth
        self.withText = false
        self.image = image
    }
    
    init(progress: Double, color: Color, lineWidth: CGFloat) {
        self.progress = progress
        self.color = color
        self.fontSize = .largeTitle
        self.lineWidth = lineWidth
        self.withText = false
        self.image = ""
    }
    
    var body: some View {
        ZStack {
            
            Image(image)
                .renderingMode(.template)
                .foregroundStyle(.primary)

            Group {
                
                Circle()
                    .stroke(
                        .background,
                        lineWidth: lineWidth
                )
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
            }
            .frame(width: 245)
            
            if withText {
                Text("\(progress * 100, specifier: "%.0f")%")
                    .font(fontSize)
                    .fontWeight(.black)
                    .fontDesign(.rounded)
            }
        }
    }
}

struct CircularProgressBarTestView: View {
    @State var progress: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                CircularProgressBar(progress: progress, color: .primary, lineWidth: 15, image: "yinYang")
            }
            .padding()
            Spacer()
            HStack {
                Slider(value: $progress, in: 0...1)
                Button("Reset") {
                    resetProgress()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
    
    func resetProgress() {
        progress = 0
    }
}

#Preview {
    CircularProgressBarTestView()
}
