//
//  HomeAppUserRow.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct HomeAppUserRow: View {
    var items: [AppUser]
    
    @State var showingMenu = false
    @State var activateGroup = false
    
    @State var requets: [AppUser] = []
    
    func addAppUserToRequests(appUser: AppUser) {
        requets.append(appUser)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(self.items) { appUser in
                    VStack() {
                            RowItem(appUser: appUser)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
//        .frame(height: 340)
        .frame(height: 440)
            .padding(.vertical, 25)
            .sheet(isPresented: $showingMenu) {
                AppUserDetail(
                    appUser: self.items[0]
        )
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

struct RowItem: View {
    var appUser: AppUser
            
            var gradient: LinearGradient {
                LinearGradient(
                    gradient: Gradient(
                        colors:
                        [
//                            Color ("Peach"),
//                            .pink,
                            Color ("Midnight"),
                            Color ("Darknight"),
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
    
    var body: some View {
        VStack(alignment: .leading) {
            appUser.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 280 ,height:390)
//                .frame(width: 210 ,height:293)
                .overlay(AppUserTextOverlay(appUser: appUser))
                .cornerRadius(8)
                .shadow(radius: 3, x: 0, y: 2)
                
//                .frame(height: 410)
                
                HStack(){
                    Spacer()
                    
                    // Button 1
                    if appUser.searchParameter.isFoodSelected {
                        
                        Button(action: {
//                            self.setSelectedScreen(screenIndex: 1)
                        }) {
                            Circle()
                                .fill(gradient)
//                                .fill(selectedScreen == 1 ? gradient : gradientGray)
                                .overlay(
                                              
                                    Image("cook")
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
//                                        .foreground(Color ("Midnight"))
                                        .foreground(Color ("BabyBlue"))
                            )
                            .frame(width: 44, height: 44)
                        }
                    }
                    
                    // Button 2
                    if appUser.searchParameter.isEntertainmentSelected {
                        
                        Button(action: {
//                            self.setSelectedScreen(screenIndex: 1)
                        }) {
                            Circle()
                                .fill(gradientGray)
//                                .fill(selectedScreen == 1 ? gradient : gradientGray)
                                .overlay(
                                              
                                    Image("clap")
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width: 25, height: 25)
                                        .scaledToFill()
                                        .foreground(Color ("BrightGray"))
                            )
                            .frame(width: 44, height: 44)
                        }
                    }
                    
                    // Button 3
                    if appUser.searchParameter.isSportSelected {
                        Button(action: {
//                            self.setSelectedScreen(screenIndex: 1)
                        }) {
                            Circle()
                                .fill(gradientGray)
                                .overlay(
                                    Image(systemName: "person.3.fill")
                                        .font(.avenirNextRegular(size: 16))
//                                        .animation(.easeInOut(duration: 0.5))
                                        .fixedSize()
                                        .frame(height: 10.0)
                                        .padding(.horizontal)
                                        .padding(.vertical, 10.0)
                                        .foreground(Color("BrightGray"))
                            )
                            .frame(width: 44, height: 44)
                            
                        }
                    }

                    Spacer()
                }
                .background(Color .white)
                .cornerRadius(4.0)
        }
        .padding(.horizontal, 10)
    }
}

struct AppUserTextOverlay: View {
    var appUser: AppUser
    @State var tempUser: AppUser?
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.8), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle().fill(gradient)
            
            HStack() {
                VStack() {
                    Spacer()
                    HStack(){
                        VStack(alignment: .leading){
                            
                            
                            // Button 1
                            Button(action: {
                                
                            }) {
                                VStack(){
                                    HStack(){
                                        Text(appUser.username)
                                            .font(.avenirNextRegular(size: 22))
                                            .fontWeight(.bold)
                                            .offset(y: 15)
                                        Spacer()
                                    }
                                    HStack(){
                                                                
                                        Image("locationBlack")
                                            .resizable()
                                            .renderingMode(.original)
                                            .frame(width: 16, height: 16)
                                            .scaledToFill()
                                            .foreground(makeGradient(colors: [.white, .white]))
                                        
//                                        Image(systemName: "location")
//                                            .font(.avenirNextRegular(size: 16))
                                        Text(appUser.searchParameter.locationName)
                                            .font(.avenirNextRegular(size: 16))
                                            .allowsTightening(true)
                                            .lineLimit(1)
//                                            .padding(.leading, 5)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
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

struct HomeAppUserRow_Previews: PreviewProvider {
    
    static var previews: some View {
            HomeAppUserRow(
                items: Array(appUserData.prefix(4))
                
            )
        }
}
