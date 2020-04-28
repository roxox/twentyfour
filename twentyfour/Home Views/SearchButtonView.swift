//
//  SearchButtonView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct SearchButtonView: View {
    @State var showButtons = false
    @State var selectedScreen = 0
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                Color.black.opacity(0.2),
                Color.black.opacity(0.0),
            ]),
//            startPoint: .topLeading,
//            endPoint: .bottomTrailing)
            startPoint: .top,
            endPoint: .bottom)
    }
    
    var gradientColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
//                    Color ("Sea"),
//                    Color ("AmaBlue"),
//                    Color ("Peach"),
//                    Color .red,
                    .pink,
                    .pink,
                    Color ("Peach"),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
        
        var gradientColor2: LinearGradient {
            LinearGradient(
                gradient: Gradient(
                    colors:
                    [
                    Color ("Peach"),
//                        Color ("Violet"),
                        .pink
    //                    Color ("AmaGreen"),
    //                    Color ("Peach"),
    //                    Color .red,
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
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func setSelectedScreen(screenIndex: Int){
        self.selectedScreen = screenIndex
    }
    
    var body: some View {
        
            ZStack(alignment: .top) {

//                Rectangle().fill(gradient)
                Rectangle().fill(Color .clear)
                    .frame(height: 120)
//                .shadow(radius: 0.4)
                
                
//                    .edgesIgnoringSafeArea(.all)
                HStack(){
                    Spacer()
                // Button 1
                Button(action: {
                    self.showButtons.toggle()
                }) {
                    HStack() {
                        
//                        Image("locator")
//                            .resizable()
//                            .renderingMode(.original)
//                            .frame(width: 20, height: 20)
//                            .scaledToFill()
//
//                        Text("Los Angeles")
//                            .font(.avenirNextRegular(size: 15))
//                            .fontWeight(.semibold)
//                            .fixedSize()
//                            .truncationMode(.head)
//
//                        Divider()
//                            .foreground(Color .black)



                        Text("Suche ändern")
                            .font(.avenirNextRegular(size: 15))
                            .fontWeight(.bold)
                            .fixedSize()
                            .truncationMode(.head)
                        
                        Image(systemName: "chevron.down")
                            .font(.headline)
                            .fixedSize()
//                            .padding(.trailing)
                    }
//                    .foreground(Color("White"))
                    .foreground(Color("Darknight"))

//                    .foreground(makeGradient(colors: [
//                        Color ("Sea"),
//                        Color ("AmaBlue")
//                        ]
//                    ))
                    
                }
                .fixedSize()
//                .foregroundColor(.black)
                .frame(height: 46)
                    .padding(.horizontal)
////                .frame(minWidth: 0, maxWidth: .infinity)
//                .background(makeGradient(colors: [
//                        Color ("Sea"),
//                        Color ("AmaBlue"),
//                ]))
                    .background(gradientGray)
                .cornerRadius(23.0)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 23)
//                            .stroke(Color ("DarkGray"), lineWidth: 0.1)
//                )
//            }
                
////                 Button Person
//                                    Button(action: {
//                                        self.setSelectedScreen(screenIndex: 0)
//                                    }) {
//                                        Circle()
//                                            .fill(selectedScreen == 0 ? gradientColor : gradientGray)
//                //                        .fill(Color ("BrightGray"))
//                                        .overlay(
//                                            Image(systemName: "person.fill")
//                                                .font(.avenirNextRegular(size: selectedScreen == 0 ? 18 : 16))
//                                                .animation(.easeInOut(duration: 0.5))
//                                            .fixedSize()
//                                            .frame(height: 10.0)
//                                            .padding(.horizontal)
//                                            .padding(.vertical, 10.0)
//                                            .foreground(Color(selectedScreen == 0 ? "Darknight" : "DarkGray"))
//
//                //                                .foregroundColor(.white)
//                                        )
//                                            .frame(width: 48, height: 48)
//
//                                    }
//
//                    //                Button Group
//                                    Button(action: {
//                                        self.setSelectedScreen(screenIndex: 1)
//                                    }) {
//                                        Circle()
//                                            .fill(selectedScreen == 1 ? gradientColor : gradientGray)
//                                            .overlay(
//                                                Image(systemName: "person.3.fill")
//                                                    .font(.avenirNextRegular(size: selectedScreen == 1 ? 18 : 16))
//                                                    .animation(.easeInOut(duration: 0.5))
//                                                    .fixedSize()
//                                                    .frame(height: 10.0)
//                                                    .padding(.horizontal)
//                                                    .padding(.vertical, 10.0)
//                                                    .foreground(Color(selectedScreen == 1 ? "Darknight" : "DarkGray"))
//
//                                        )
//                                        .frame(width: 48, height: 48)
//
//                                    }

            
            Spacer()
                }
                .padding([.leading, .trailing], 20)
                .padding([.top], 60)
//                .shadow(radius: 3, x: 0, y: 2)
//            .animation(.easeInOut(duration: 0.1))
        }
//        }.edgesIgnoringSafeArea(.all)
    }
}

struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView()
    }
}
