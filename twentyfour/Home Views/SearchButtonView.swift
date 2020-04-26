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
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
//                    Color ("AmaGreen"),
//                    Color ("AmaBlue"),
                    
                    Color ("Sea"),
                    Color ("AmaBlue"),
//
//                    Color("Cherry"),
//                    Color ("Peach"),
//                    Color ("Peach"),
//                    Color("Cherry"),
                    
//                    Color ("CandyGreen"),
//                    Color ("Darknight"),
                    
//                    Color ("Violet"),
//                    Color ("Darknight"),
                    
//                    Color("Cherry")
//                    Color ("Mint"),
//                    Color ("Sea"),

//                    Color("Cherry"),
//                    .pink,
//                                        Color ("Darknight"),
//                    .orange
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
        
        var gradientGray: LinearGradient {
            LinearGradient(
                gradient: Gradient(
                    colors:
                    [
    //                    Color ("AmaGreen"),
    //                    Color ("AmaBlue"),
                        Color ("SuperLightGray"),
                        Color ("SuperLightGray"),
    //                    Color ("CandyGreen"),
    //                    Color ("Darknight"),
    //                    Color ("Violet"),
    //                    Color ("Darknight"),
    //                    .purple,
    //                    Color ("DarkGreen"),
    //                    Color ("Sea"),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        }

                
            var gradientPeach: LinearGradient {
                LinearGradient(
                    gradient: Gradient(
                        colors:
                        [
//                            Color ("AmaGreen"),
//                            Color ("AmaBlue"),
                            
//                            Color ("Sea"),
//                            Color ("AmaBlue"),

//                            Color ("Peach"),
                            Color ("SuperLightGray"),
                            Color ("LightGray"),
//                            .pink
                            
//                            Color ("DarkGray"),
//                            Color ("DarkGray"),
                            
        //                    Color ("CandyGreen"),
        //                    Color ("Darknight"),
        //                    Color ("Violet"),
        //                    Color ("Darknight"),
        //                    .purple,
        //                    Color ("DarkGreen"),
        //                    Color ("Sea"),
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
    
    var body: some View {
        
            ZStack(alignment: .top) {

//                Rectangle().fill(gradient)
                Rectangle().fill(Color .white)
                    .frame(height: 120)
                .shadow(radius: 0.4)
                
                
//                    .edgesIgnoringSafeArea(.all)
                
                // Button 1
                Button(action: {
                    self.showButtons.toggle()
                }) {
                    HStack() {
//                        Image(systemName: "location")
//                            .font(.headline)
//                            .fixedSize()
//                            .padding(.leading)
                        
                        Image("locationBlack")
//                            .font(.avenirNextRegular(size: 18))
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 20, height: 20)
                            .scaledToFill()
                            .foreground(Color("DarkGray"))
                        
                        Text("Los Angeles (Californ...")
                            .font(.avenirNextRegular(size: 15))
                            .fontWeight(.semibold)
                            .fixedSize()
                            .truncationMode(.head)
                            .foreground(Color("DarkGray"))
                        
                        Divider()
                            .foreground(Color .black)
                        
                        
                        
                        Text("Suche anpassen")
                            .font(.avenirNextRegular(size: 15))
                            .fontWeight(.semibold)
                            .fixedSize()
                            .truncationMode(.head)
                            .foreground(Color("DarkGray"))
                            
//                        Button(action: {
//                        }) {
//                                    Image("cook")
//                                        .resizable()
//                                        .renderingMode(.original)
//                                        .frame(width: 20, height: 20)
//                                        .scaledToFill()
//                                        .foreground(Color("DarkGray"))
//                        }
//
//
//                        Button(action: {
//                        }) {
//                                    Image("clap")
//                                        .resizable()
//                                        .renderingMode(.original)
//                                        .frame(width: 20, height: 20)
//                                        .scaledToFill()
//                        }
//
//
//                        Button(action: {
//                        }) {
//                            Image(systemName: "person.3")
//                            .foreground(Color("DarkGray"))
//                            .font(.avenirNextRegular(size: 18))
//                        }
                        
//                        Divider()
//                            .foreground(Color .black)
                        
                        Image(systemName: "chevron.down")
                            .font(.headline)
                            .fixedSize()
                            .padding(.trailing)
                            .foreground(Color("DarkGray"))
                    }
                    .foreground(Color("DarkGray"))
                    
                }
                .fixedSize()
//                .foregroundColor(.black)
                .frame(height: 45)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color .white)
                .cornerRadius(8.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color ("DarkGray"), lineWidth: 0.1)
                )
                .shadow(radius: 3, x: 0, y: 2)
                .padding([.leading, .trailing], 20)
                .padding([.top], 50)
//            }
            
            Spacer()
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
