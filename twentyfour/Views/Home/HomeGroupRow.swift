//
//  HomeGroupRow.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreGroupView: View {
    var items: [Profile]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items) { appUser in
                        NavigationLink(
                            destination: ProfileDetail(
                                appUser: appUser
                            )
                        ) {
                            GroupRowItem(items: self.items, appUser: appUser)
                        }
                        .buttonStyle(ListButtonStyle())
                    }
                }
            }
            .shadow(radius: 5)
            .frame(height: 330)
        }
        .padding(.vertical, 25)
    }
    
    func makeGradient() -> some View {
        LinearGradient(
                    gradient: .init(colors: [
                        Color("Sea")
                        , Color("CandyGreen")
                    ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// Origin item size h290 x w210
struct GroupRowItem: View {
        var items: [Profile]
        var appUser: Profile
    
        var body: some View {
                HStack(){
                    
                    ForEach(self.items) { user in
                        user.image
                        .resizable()
                        .renderingMode(.original)
                        .scaledToFill()
                            .frame(width: CGFloat(350/self.items.count), height: 280.0)
                            .padding(0)
                    }
                }
            .overlay(GroupTextOverlay(appUser: appUser))
            .cornerRadius(8)
            .padding(.leading, 15)
        }
    }

struct GroupTextOverlay: View {
    var appUser: Profile
    
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
//                                    HStack(){
//                                        Text(appUser.username)
//                                            .font(.avenirNextRegular(size: 22))
//                                            .fontWeight(.bold)
//                                            .offset(y: 15)
//                                        Spacer()
//                                    }
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
                                            .padding(.leading, 5)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.bottom, 10)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
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

struct HomeGroupRow_Previews: PreviewProvider {
    static var previews: some View {
            ExploreGroupView(
//                categoryName: "Andere User",
                items: Array(appUserData.prefix(4))
            )
//            .environmentObject(UserData())
        }
}

struct ListButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {

        configuration.label
            .overlay(Color.clear)
    }
}
