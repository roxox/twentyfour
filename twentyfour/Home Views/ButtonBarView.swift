//
//  ButtonBarView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 20.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ButtonBarView: View {
    
//    @State var tabBarIndex: Int = 0
    @Binding var tabBarIndex: Int
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    var barGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color ("RedPeach"),
                    Color ("RedPeach")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    func colorReturn(value: Int) -> Color {
        if tabBarIndex == value {
            return Color ("RedPeach")
//            return Color .pink
        } else {
            return Color ("DarkGray")
        }
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
                .shadow(radius: 2, x: 0, y: 2)
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 40)
            
            VStack(alignment: .leading) {
            HStack() {
                Spacer()
                VStack() {
                    Rectangle().fill(tabBarIndex == 0 ? barGradient : barGradientWhite)
                        .frame(width: 50, height: 2)
                        .cornerRadius(4.0)
                        .fixedSize()
                        .padding(.top, 6)
                        .offset(x: 0, y: 6)
                        .animation(.easeInOut(duration: 0.2))
                    // Button 1
                    Button(action: {
                        self.tabBarIndex = 0
                    }) {
                        Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .medium))
//                            .font(.avenirNextRegular(size: 20))
//                            foreground(barGradient)
                            .foregroundColor(colorReturn(value: 0))
                        }
                        .fixedSize()
                        .padding()
                }
                
                Spacer()

                VStack() {
                    Rectangle().fill(tabBarIndex == 1 ? barGradient : barGradientWhite)
                        .frame(width: 50, height: 2)
                        .cornerRadius(8.0)
                        .fixedSize()
                        .padding(.top, 6)
                        .offset(x: 0, y: 6)
                        .animation(.easeInOut(duration: 0.2))
                    // Button 1
                    Button(action: {
                        self.tabBarIndex = 1
                    }) {
                        Image(systemName: "person.3")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(colorReturn(value: 1))
                    }
                    .fixedSize()
                    .padding()
                }
                Spacer()

                VStack() {
                    Rectangle().fill(tabBarIndex == 2 ? barGradient : barGradientWhite)
                        .frame(width: 50, height: 2)
                        .cornerRadius(8.0)
                        .fixedSize()
                        .padding(.top, 6)
                        .offset(x: 0, y: 6)
                        .animation(.easeInOut(duration: 0.2))
                    // Button 1
                    Button(action: {
                        self.tabBarIndex = 2
                    }) {
                        Image(systemName: "envelope")
                        .font(.system(size: 20, weight: .medium))
                            .foregroundColor(colorReturn(value: 2))
                        }
                        .fixedSize()
                        .padding()
                }
                Spacer()

                VStack() {
                    Rectangle().fill(tabBarIndex == 3 ? barGradient : barGradientWhite)
                        .frame(width: 50, height: 2)
                        .cornerRadius(8.0)
                        .fixedSize()
                        .padding(.top, 6)
                        .offset(x: 0, y: 6)
                        .animation(.easeInOut(duration: 0.2))
                    // Button 1
                    Button(action: {
                        self.tabBarIndex = 3
                    }) {
                        Image(systemName: "person")
                        .font(.system(size: 20, weight: .medium))
                            .foregroundColor(colorReturn(value: 3))
                        }
                        .fixedSize()
                        .padding()
                }
                Spacer()
                
                }
                .padding(.bottom, 45)
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

//struct ButtonBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonBarView()
//    }
//}
