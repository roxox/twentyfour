//
//  ButtonBarView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 20.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ButtonBarView: View {
    
    @State var tabBarIndex: Int = 0
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.5), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var barGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
//                colors: [Color.pink, Color.pink]),
//                colors: [Color.pink, Color("Cherry")]),
//                colors: [Color("AmaGreen"), Color("AmaBlue")]),
//                colors: [Color("AmaGreen"), Color("AmaBlue")]),
                colors: [Color("Peach"), .pink]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var barGradientWhite: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.clear, Color.clear]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
                .frame(height: 90)
            
            Rectangle()
                .frame(height: 55)
                .cornerRadius(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color ("DarkGray"), lineWidth: 0.1)
                )
                .shadow(radius: 3, x: 0, y: 2)
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 30)
            
            VStack(alignment: .leading) {
            HStack() {
                Spacer()
                VStack() {
                    Rectangle().fill(tabBarIndex == 0 ? barGradient : barGradientWhite)
                        .frame(width: 50, height: 4)
                        .cornerRadius(8.0)
                        .fixedSize()
                        .padding(.top, 8)
                        .offset(x: 0, y: 8)
                        .animation(.easeInOut(duration: 0.2))
                    // Button 1
                    Button(action: {
                        self.tabBarIndex = 0
                    }) {
                        Image(systemName: "house")
                            .font(.avenirNextRegular(size: 20))
                            .foregroundColor(Color("DarkGray"))
                        }
                        .fixedSize()
                        .padding()
                }
                
                Spacer()

                VStack() {
                    Rectangle().fill(tabBarIndex == 1 ? barGradient : barGradientWhite)
                        .frame(width: 50, height: 4)
                        .cornerRadius(8.0)
                        .fixedSize()
                        .padding(.top, 8)
                        .offset(x: 0, y: 8)
                        .animation(.easeInOut(duration: 0.2))
                    // Button 1
                    Button(action: {
                        self.tabBarIndex = 1
                    }) {
                        Image(systemName: "heart")
                        .font(.avenirNextRegular(size: 20))
                        .foregroundColor(Color("DarkGray"))
                    }
                    .fixedSize()
                    .padding()
                }
                Spacer()

                VStack() {
                    Rectangle().fill(tabBarIndex == 2 ? barGradient : barGradientWhite)
                        .frame(width: 50, height: 4)
                        .cornerRadius(8.0)
                        .fixedSize()
                        .padding(.top, 8)
                        .offset(x: 0, y: 8)
                        .animation(.easeInOut(duration: 0.2))
                    // Button 1
                    Button(action: {
                        self.tabBarIndex = 2
                    }) {
                        Image(systemName: "envelope")
                            .font(.avenirNextRegular(size: 20))
                            .foregroundColor(Color("DarkGray"))
                        }
                        .fixedSize()
                        .padding()
                }
                Spacer()

                VStack() {
                    Rectangle().fill(tabBarIndex == 3 ? barGradient : barGradientWhite)
                        .frame(width: 50, height: 4)
                        .cornerRadius(8.0)
                        .fixedSize()
                        .padding(.top, 8)
                        .offset(x: 0, y: 8)
                        .animation(.easeInOut(duration: 0.2))
                    // Button 1
                    Button(action: {
                        self.tabBarIndex = 3
                    }) {
                        Image(systemName: "person")
                            .font(.avenirNextRegular(size: 20))
                            .foregroundColor(Color("DarkGray"))
                        }
                        .fixedSize()
                        .padding()
                }
                Spacer()
                
                }
                .padding(.bottom, 35)
            }
        }
        .foregroundColor(.white)
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

struct ButtonBar_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBarView()
    }
}
