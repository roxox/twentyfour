//
//  ButtonBarView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 20.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ButtonBarView: View {
    
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

    var gradientColorPrimary: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    .pink,
                    .pink,
                    Color ("Peach")
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }

    var gradientColorSecondary: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("Midnight"),
                    Color ("Sea"),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }

    var gradientColorThird: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("Violet"),
//                    .pink,
                    Color ("Cherry")
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }

    var gradientColorFourth: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("DarkGreen"),
                    Color ("LightGreen")
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var gradientGray: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("SuperLightGray"),
                    Color ("SuperLightGray"),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var gradientWhite: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    .white,
                    .white,
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    func colorReturn(value: Int) -> Color {
        if tabBarIndex == value {
            return Color ("RedPeach")
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
    
    func setSelectedTab(tabBarIndex: Int){
        self.tabBarIndex = tabBarIndex
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            VStack(alignment: .leading) {
            HStack() {
                Spacer()
//                VStack() {
//                    Rectangle().fill(tabBarIndex == 0 ? barGradient : barGradientWhite)
//                        .frame(width: 50, height: 2)
//                        .cornerRadius(4.0)
//                        .fixedSize()
//                        .padding(.top, 6)
//                        .offset(x: 0, y: 6)
//                        .animation(.easeInOut(duration: 0.2))
                    

//                  Button Lupe
                Button(action: {
//                                        self.setSelectedTab(tabBarIndex: self.tabBarIndex)
                    self.tabBarIndex = 0
                }) {
                    Circle()
                        .fill(tabBarIndex == 0 ? gradientColorPrimary : gradientGray)
                        .overlay(
                            HStack() {
                                Image(systemName: "magnifyingglass")
                                    .padding(.vertical, 10.0)
                            }
                            .font(.system(size: 20, weight: .medium))
                            .foreground(tabBarIndex == 0 ? .white : Color("DarkGray"))
                    )
                        .frame(width: 55, height: 55)
                        .offset(x: -4, y: 0)
                }

                    Spacer()

//                  Button 3-People
                Button(action: {
//                                        self.setSelectedTab(tabBarIndex: self.tabBarIndex)
                    self.tabBarIndex = 1
                }) {
                    Circle()
                        .fill(tabBarIndex == 1 ? gradientColorPrimary : gradientGray)
                        .overlay(
                            HStack() {
                                Image(systemName: "person.3")
                                    .padding(.vertical, 10.0)
                            }
                            .font(.system(size: 20, weight: .medium))
                            .foreground(tabBarIndex == 1 ? .white : Color("DarkGray"))
                    )
                        .frame(width: 55, height: 55)
                        .offset(x: -4, y: 0)
                }
                
                Spacer()

//                  Button Message
                Button(action: {
//                                        self.setSelectedTab(tabBarIndex: self.tabBarIndex)
                    self.tabBarIndex = 2
                }) {
                    Circle()
                        .fill(tabBarIndex == 2 ? gradientColorPrimary : gradientGray)
                        .overlay(
                            HStack() {
                                Image(systemName: "envelope")
                                    .padding(.vertical, 10.0)
                            }
                            .font(.system(size: 20, weight: .medium))
                            .foreground(tabBarIndex == 2 ? .white : Color("DarkGray"))
                    )
//                        .overlay(
//                            Circle()
//                                .stroke(Color ("AlmostBlack"), lineWidth: 3.0)
//                    )
                        .frame(width: 55, height: 55)
                        .offset(x: -4, y: 0)
                }
                
                Spacer()
                
//                  Button Profile
                Button(action: {
//                                        self.setSelectedTab(tabBarIndex: self.tabBarIndex)
                    self.tabBarIndex = 3
                }) {
                    Circle()
                        .fill(tabBarIndex == 3 ? gradientColorPrimary : gradientGray)
                        .overlay(
                            HStack() {
                                Image(systemName: "person")
                                    .padding(.vertical, 10.0)
                            }
                            .font(.system(size: 20, weight: .medium))
                            .foreground(tabBarIndex == 3 ? .white : Color("DarkGray"))
                    )
                        .frame(width: 55, height: 55)
                        .offset(x: -4, y: 0)
                }
                Spacer()
                    
                    // Button 1
//                    Button(action: {
//                        self.tabBarIndex = 0
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                        .font(.system(size: 20, weight: .medium))
////                            .font(.avenirNextRegular(size: 20))
////                            foreground(barGradient)
//                            .foregroundColor(colorReturn(value: 0))
//                        }
//                        .fixedSize()
//                        .padding()
                        
//                }
                
//                Spacer()
//
//                VStack() {
//                    Rectangle().fill(tabBarIndex == 1 ? barGradient : barGradientWhite)
//                        .frame(width: 50, height: 2)
//                        .cornerRadius(8.0)
//                        .fixedSize()
//                        .padding(.top, 6)
//                        .offset(x: 0, y: 6)
//                        .animation(.easeInOut(duration: 0.2))
//                    // Button 1
//                    Button(action: {
//                        self.tabBarIndex = 1
//                    }) {
//                        Image(systemName: "person.3")
//                        .font(.system(size: 20, weight: .medium))
//                        .foregroundColor(colorReturn(value: 1))
//                    }
//                    .fixedSize()
//                    .padding()
//                }
//                Spacer()
//
//                VStack() {
//                    Rectangle().fill(tabBarIndex == 2 ? barGradient : barGradientWhite)
//                        .frame(width: 50, height: 2)
//                        .cornerRadius(8.0)
//                        .fixedSize()
//                        .padding(.top, 6)
//                        .offset(x: 0, y: 6)
//                        .animation(.easeInOut(duration: 0.2))
//                    // Button 1
//                    Button(action: {
//                        self.tabBarIndex = 2
//                    }) {
//                        Image(systemName: "envelope")
//                        .font(.system(size: 20, weight: .medium))
//                            .foregroundColor(colorReturn(value: 2))
//                        }
//                        .fixedSize()
//                        .padding()
//                }
//                Spacer()
//
//                VStack() {
//                    Rectangle().fill(tabBarIndex == 3 ? barGradient : barGradientWhite)
//                        .frame(width: 50, height: 2)
//                        .cornerRadius(8.0)
//                        .fixedSize()
//                        .padding(.top, 6)
//                        .offset(x: 0, y: 6)
//                        .animation(.easeInOut(duration: 0.2))
//                    // Button 1
//                    Button(action: {
//                        self.tabBarIndex = 3
//                    }) {
//                        Image(systemName: "person")
//                        .font(.system(size: 20, weight: .medium))
//                            .foregroundColor(colorReturn(value: 3))
//                        }
//                        .fixedSize()
//                        .padding()
//                }
//                Spacer()
//
                }
                .padding(.bottom, 20)
//                .padding()
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
