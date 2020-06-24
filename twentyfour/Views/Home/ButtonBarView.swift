//
//  ButtonBarView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 20.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ButtonBarView: View {
    
    @Binding var pageIndex: Int
    
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
                    Color ("White"),
                    Color ("White"),
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
                    Color ("AlmostBlack"),
                    Color ("AlmostBlack"),
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
        if pageIndex == value {
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
    
    func setSelectedTab(pageIndex: Int){
        self.pageIndex = pageIndex
    }
    
//      gradientPeachPink
//      gradientPinkPurple
//      gradientPurpleBlue
//      gradientBlueAccent
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            VStack(alignment: .leading) {
                Divider()
            HStack() {
                Spacer()
                
                // Lupe
                Button(action: {
                    self.pageIndex = 0
                }) {
                    VStack() {
//                        Circle().fill(pageIndex == 0 ? gradientColorSecondary : gradientColorSecondary)

                        Image(systemName: "magnifyingglass")
                            .padding(.vertical, 10.0)
                            .font(.system(size: 20, weight: .semibold))
                            .frame(width: 40, height: 24)
                            .foreground(pageIndex == 0 ? gradientPeachPink : gradientGray)
                            .offset(x: 0, y: 0)
//                            .overlay(
//                                Image(systemName: "person")
//                                    .padding(.vertical, 10.0)
//                                    .font(.system(size: 20, weight: .medium))
//                                    .foreground(pageIndex == 0 ? gradientPeachPink : gradientGray)
//                                    .frame(width: 40, height: 40)
//                                    .offset(x: 0, y: 0)
//                                )
//                            .frame(width: 45, height: 45)
                        
                    Text("Stöbern")
                        .font(.avenirNextRegular(size: 11))
                        .fontWeight(.semibold)
                        .foreground(pageIndex == 0 ? gradientPeachPink : gradientGray)
                    }
                }

                Spacer()

//                  Button My Groups
                Button(action: {
                    self.pageIndex = 1
                }) {
                    VStack() {

                        Image(systemName: "person.3")
//                            .padding(.vertical, 10.0)
                            .font(.system(size: 20, weight: .semibold))
                            .frame(width: 40, height: 24)
                            .foreground(pageIndex == 1 ? gradientPeachPink : gradientGray)
                            .offset(x: 0, y: 0)
//                        Circle().fill(pageIndex == 1 ? gradientColorSecondary : gradientColorSecondary)
//                            .overlay(
//                                Image(systemName: "person.3")
//                                    .padding(.vertical, 10.0)
//                                    .font(.system(size: 20, weight: .medium))
//                                    .foreground(pageIndex == 1 ? gradientPinkPurple : gradientGray)
//                                    .frame(width: 40, height: 40)
//                                    .offset(x: 0, y: 0)
//                                )
//                            .frame(width: 45, height: 45)

                        Text("Meine Gruppen")
                            .font(.avenirNextRegular(size: 11))
                            .fontWeight(.semibold)
                            .foreground(pageIndex == 1 ? gradientPeachPink : gradientGray)
                    }
                }

                Spacer()

//                  Button Message
                Button(action: {
                    self.pageIndex = 2
                }) {
                    VStack() {
//                        Circle().fill(pageIndex == 2 ? gradientColorPrimary : gradientColorSecondary)
                                Image(systemName: "bubble.left")
                                    .padding(.vertical, 10.0)
                                    .font(.system(size: 20, weight: .semibold))
//                                    .foreground(pageIndex == 2 ? gradientColorSecondary : gradientGray)
                                    .frame(width: 40, height: 24)
                                    .foreground(pageIndex == 2 ? gradientPeachPink : gradientGray)
                                    .offset(x: 0, y: 0)
//                        Circle().fill(pageIndex == 2 ? gradientColorSecondary : gradientColorSecondary)
//                            .overlay(
//                                Image(systemName: "envelope")
//                                    .padding(.vertical, 10.0)
//                                    .font(.system(size: 20, weight: .medium))
////                                    .foreground(pageIndex == 2 ? gradientColorSecondary : gradientGray)
//                                    .foreground(pageIndex == 2 ? gradientPurpleBlue : gradientGray)
//                                    .frame(width: 40, height: 40)
//                                    .offset(x: 0, y: 0)
//                                )
//                            .frame(width: 45, height: 45)

                        Text("Nachrichten")
                            .font(.avenirNextRegular(size: 11))
                            .fontWeight(.semibold)
//                            .foreground(pageIndex == 2 ? gradientColorPrimary : gradientGray)
                            .foreground(pageIndex == 2 ? gradientPeachPink : gradientGray)
                    }
                }

                Spacer()

//                  Button Profil
                Button(action: {
                    self.pageIndex = 3
                }) {
                    VStack() {
                        Image(systemName: "person")
                        .padding(.vertical, 10.0)
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: 40, height: 24)
                        .foreground(pageIndex == 3 ? gradientPeachPink : gradientGray)
                        .offset(x: 0, y: 0)
//                        Circle().fill(pageIndex == 3 ? gradientColorSecondary : gradientColorSecondary)
//                            .overlay(
//                                Image(systemName: "person")
//                                    .padding(.vertical, 10.0)
//                                    .font(.system(size: 20, weight: .medium))
//                                    .foreground(pageIndex == 3 ? gradientBlueAccent : gradientGray)
//                                    .frame(width: 40, height: 40)
//                                    .offset(x: 0, y: 0)
//                                )
//                            .frame(width: 45, height: 45)

                        Text("Profil")
                            .font(.avenirNextRegular(size: 11))
                            .fontWeight(.semibold)
                            .foreground(pageIndex == 3 ? gradientPeachPink : gradientGray)
                    }
                }

                Spacer()
                }
                .padding(.top, 10)
//                .padding()
            }
            .background(Color ("background1"))
        }
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
