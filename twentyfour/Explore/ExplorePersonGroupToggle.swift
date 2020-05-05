//
//  ExplorePersonGroupToggle.swift
//  twentyfour
//
//  Created by Sebastian Fox on 28.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExplorePersonGroupToggle: View {
    
    @Binding var pageIndex: Int
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    var gradientMenu: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .top)
    }

    var gradientColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    .pink,
                    .pink,
                    Color ("Peach")
//                    Color ("AlmostBlack"),
//                    Color ("AlmostBlack")
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
    
    func setSelectedScreen(newPageIndex: Int){
        self.pageIndex = newPageIndex
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var body: some View {
        VStack() {
            ZStack()
            {
    //            Toggle Center Bar
                Rectangle().fill(Color ("SuperLightGray"))
                    .frame(width: 48, height: 38)
//                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
            
                HStack() {
    //                    Button Person
                    Button(action: {
                        self.setSelectedScreen(newPageIndex: 0)
                    }) {
                        RoundedRectangle(cornerRadius: pageIndex == 0 ? 21 : 19)
                            .fill(pageIndex == 0 ? gradientColor : gradientGray)
                            .overlay(
                                HStack() {
                                    Image(systemName: "person.fill")
                                        .padding(.vertical, 10.0)
                                }
                                .font(.avenirNextRegular(size: 16))
                                .foreground(pageIndex == 0 ? .white : Color("DarkGray"))
                            
                        )
                            .frame(width: pageIndex == 0 ? 52 : 48, height: pageIndex == 0 ? 42 : 38)
                            .offset(x: 4, y: 0)
                    }
//                    .buttonStyle(ListButtonStyle())

    //                    Button Group
                    Button(action: {
                        self.setSelectedScreen(newPageIndex: 1)
                    }) {
                        RoundedRectangle(cornerRadius: pageIndex == 1 ? 21 : 19)
                            .fill(pageIndex == 1 ? gradientColor : gradientGray)
                            .overlay(
                                HStack() {
                                    Image(systemName: "person.3.fill")
                                        .padding(.vertical, 10.0)
                                    }
                                    .font(.avenirNextRegular(size: 16))
                                    .foreground(pageIndex == 1 ? .white : Color("DarkGray"))
//                                    .foreground(makeGradient(colors: [Color ("Sea"), Color ("Peach")]))
                                
                                
                        )
                        .frame(width: pageIndex == 1 ? 52 : 48, height: pageIndex == 1 ? 42 : 38)
                        .offset(x: -4, y: 0)
                    }
//                    .buttonStyle(ListButtonStyle())
                }
            }
            .padding(.bottom, 25)            
        }
    }
}

struct ExplorePersonGroupToggle_Previews: PreviewProvider {
    @State static var pageIndex = 0 // Note: it must be static
    
    static var previews: some View {
        ExplorePersonGroupToggle(
            pageIndex: $pageIndex
        )
    }
}
