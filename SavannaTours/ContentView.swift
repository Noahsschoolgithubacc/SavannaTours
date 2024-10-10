//
//  ContentView.swift
//  SavannaTours
//
//  Created by PM Student on 10/8/24.
//

import SwiftUI

struct ContentView: View {
    
@State var zoomed = false
    
    var body: some View {
        VStack {
            Image("hero")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(height: 300)
            
            ZStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Savanna Tours")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 5)
                        .foregroundColor(.white)
                    
                    Text("15-mile drive followed by an hour-long trek")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                // caused text to appear behind zoomed image
//                .offset(x: 30, y: -30)
                
                // causes text to not be seen when zoomed
                .offset(x: zoomed ? 500 : 30, y: -30)
                
                withAnimation(.default) {
                    GeometryReader { geometry in
                        Image("thumb")
                            .clipShape(
                                // keeps circle around image
//                                RoundedRectangle(cornerRadius: 500))
                                
                                // adds square
                                RoundedRectangle(cornerRadius: zoomed ? 40 : 500))
                            .overlay(
                                Circle()
                                // this keeps circle on zommed out
//                                    .fill(Color.white.opacity(0.4))
                                
                                // this removes on zoomed out
                                    .fill(zoomed ? Color.clear : Color(white: 1, opacity: 0.4))
                                    .scaleEffect(0.8)
                            )
                        // keeps saturation consistent
//                            .saturation(0)
                        
                        // adjusts
                            .saturation(zoomed ? 1 : 0)
                        
                        // adds spin effect
                            .rotationEffect(zoomed ? .zero: Angle(radians: 6 * .pi))
                        
                        // changes position of image as it zooms out
                            .position(x: zoomed ? geometry.frame(in: .local).midX : 600, y: 50)
                        
                        // original scale
//                            .scaleEffect(1 / 3)
                        
                        // adjusts scale of image as it zooms out
                            .scaleEffect((zoomed ? 4 : 1) / 3)
                        
                            .shadow(radius: 10)
                        
                        // this transition has a smooth zoom effect
                           .animation(.default, value: zoomed)
                        
                        // this transition has a spring effect
//                            .animation(.spring(), value: zoomed)
                        
                        // image will toggle between zommed and not(false)
                            .onTapGesture {
                                zoomed.toggle()
                            }
                    }
                }
            }
            .background(Color(white: 0.1))
            
            
            List(0...4, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text("Milestone #\(index + 1)")
                        .font(.title)
                    HStack {
                        Text("Savanna national park (\(index * 12 + 5)km")
                        Image(systemName: "pin")
                        Spacer()
                        Text("South Africa")
                            .font(.subheadline)
                        
                        
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
