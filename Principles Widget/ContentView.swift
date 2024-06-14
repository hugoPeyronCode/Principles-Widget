//
//  ContentView.swift
//  Principles Widget
//
//  Created by Hugo Peyron on 14/06/2024.
//

import SwiftUI

struct Principle: Identifiable {
    var id = UUID()
    let principle: String
    var isSelected : Bool
}

struct ContentView: View {
    @State var principle1 : String
    var body: some View {
        VStack {
            Text("My Principles")
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading) {
                ScrollView {
                    PrincipleView()
                }
            }
        }
        .padding()
        .fontDesign(.monospaced)
    }
}

#Preview {
    ContentView(principle1: "nothing")
}

struct PrincipleView : View {
    
    let principle : Principle = Principle(principle: "Respect everyone", isSelected: true)
    
    var body: some View {
        HStack {
            Text("1")
            Spacer()
            Text(principle.principle)
            Spacer()
        }
    }
}
