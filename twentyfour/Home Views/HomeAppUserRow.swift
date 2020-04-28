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
    @Binding var groupList: [AppUser]
    
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
                        RowItem(appUser: appUser, groupList: self.$groupList)
//                        .shadow(radius: 3, x: 0, y: 2)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
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
}

struct RowItem: View {
    var appUser: AppUser
    @Binding var groupList: [AppUser]
    
    var body: some View {
        VStack(alignment: .leading) {
            appUser.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 280 ,height:360)
                .overlay(AppUserTextOverlay(appUser: appUser, groupList: $groupList))
                .background(Color .white)
                .cornerRadius(15.0)
                .shadow(radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
    }
}

struct AppUserTextOverlay: View {
    var appUser: AppUser
    @Binding var groupList: [AppUser]
    
    @State var tempUser: AppUser?
    @State var showInfoPanel: Bool = true
    @State var topOpacity: Double = 0.0
    @State var bottomOpacity: Double = 0.8
    @State var unitPointTop: UnitPoint = .center
    
    func toggleInfoPanel(newValue: Bool) {
        topOpacity = (!showInfoPanel ? 0.0 : 0.7)
        bottomOpacity = (!showInfoPanel ? 0.6 : 0.7)
        if newValue == true {
            unitPointTop = .top
            groupList.append(appUser)
        } else {
            unitPointTop = .center
            if groupList.contains(appUser) {
                groupList.remove(at: self.groupList.firstIndex(of: appUser)!)
            }
        }
        showInfoPanel = !newValue
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(bottomOpacity), Color.black.opacity(topOpacity)]),
            startPoint: .bottom,
            endPoint: unitPointTop)
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
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
                                self.toggleInfoPanel(newValue: self.showInfoPanel)
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
}

//struct HomeAppUserRow_Previews: PreviewProvider {
//
//    static var previews: some View {
//            HomeAppUserRow(
//                items: Array(appUserData.prefix(4))
//
//            )
//        }
//}
