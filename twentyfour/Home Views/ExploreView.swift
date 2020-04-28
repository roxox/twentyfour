//
//  ExploreView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
        var items: [AppUser]
        
        @State var showingMenu = false
        @State var activateGroup = false
        @State var selectedScreen = 0
        @State var showButtons = false
        
        @State var requets: [AppUser] = []
    
        @Binding var groupList: [AppUser]
        
        func addAppUserToRequests(appUser: AppUser) {
            requets.append(appUser)
        }
    
    func setSelectedScreen(screenIndex: Int){
        self.selectedScreen = screenIndex
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
        
        var gradient: LinearGradient {
            LinearGradient(
                gradient: Gradient(
                    colors:
                    [
                        Color ("Sea"),
                        Color ("AmaBlue"),
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
                            Color ("BrightGray"),
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            }
    
    var body: some View {
        VStack(alignment: .leading) {

            VStack() {
                Text("Erkunde die Gegend. Triff neue Leute.")
                    .font(.avenirNextRegular(size: 21))
                    .fontWeight(.semibold)
//                    .background(Color .black)
                    .foreground(Color ("DarkGray"))
//                    .foreground(Color .white)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(4)
                    .padding([.leading, .trailing], 20)
//                    .padding(.vertical, 10)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                
                Text("Finde Personen und Gruppen, die innerhalb der nächsten 24 Stunden das gleiche suchen wie du! Wähle mindestens eine Person um eine Gruppe zu erstellen.")
                    .font(.avenirNextRegular(size: 16))
                    .foreground(Color ("DarkGray"))
//                    .foreground(Color .white)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(4)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
//                    .padding(.bottom, 20)
                }
//                .background(Color ("AlmostBlack"))
//                .background(Color .black)
            
//            HStack() {
//                Spacer()
////                Button Person
//                    Button(action: {
//                        self.setSelectedScreen(screenIndex: 0)
//                    }) {
//                        Circle()
//                            .fill(selectedScreen == 0 ? gradient : gradientGray)
////                        .fill(Color ("BrightGray"))
//                        .overlay(
//                            Image(systemName: "person.fill")
//                                .font(.avenirNextRegular(size: selectedScreen == 0 ? 18 : 16))
//                                .animation(.easeInOut(duration: 0.5))
//                            .fixedSize()
//                            .frame(height: 10.0)
//                            .padding(.horizontal)
//                            .padding(.vertical, 10.0)
//                            .foreground(Color(selectedScreen == 0 ? "Darknight" : "DarkGray"))
//
////                                .foregroundColor(.white)
//                        )
//                            .frame(width: 48, height: 48)
//
//                    }
//
//    //                Button Group
//                    Button(action: {
//                        self.setSelectedScreen(screenIndex: 1)
//                    }) {
//                        Circle()
//                            .fill(selectedScreen == 1 ? gradient : gradientGray)
//                            .overlay(
//                                Image(systemName: "person.3.fill")
//                                    .font(.avenirNextRegular(size: selectedScreen == 1 ? 18 : 16))
//                                    .animation(.easeInOut(duration: 0.5))
//                                    .fixedSize()
//                                    .frame(height: 10.0)
//                                    .padding(.horizontal)
//                                    .padding(.vertical, 10.0)
//                                    .foreground(Color(selectedScreen == 1 ? "Darknight" : "DarkGray"))
//                        )
//                        .frame(width: 48, height: 48)
//
//                    }
//
//                Spacer()
//            }
//            .padding(.bottom, 10)
//            .padding(.horizontal, 20)
            
            
//
//            Text("Erkunde die Gegend.")
//                .font(.avenirNextRegular(size: 21))
//                .fontWeight(.semibold)
//                .foreground(Color ("DarkGray"))
//                .fixedSize(horizontal: false, vertical: true)
//                .lineLimit(4)
//                .padding([.leading, .trailing], 20)
//                .padding(.vertical, 10)
//
//            Text("Finde Personen und Gruppen, die innerhalb der nächsten 24 Stunden das gleiche suchen wie du! Wähle mindestens eine Person um eine Gruppe zu erstellen.")
//                .font(.avenirNextRegular(size: 16))
////                .fontWeight(.semibold)
//                .foreground(Color ("DarkGray"))
//                .fixedSize(horizontal: false, vertical: true)
//                .lineLimit(4)
//                .padding([.leading, .trailing], 20)
//                .padding(.vertical, 10)
            
            // Person
            if selectedScreen == 0 {
                HomeAppUserRow(items: appUserData, groupList: $groupList)
                .frame(height: 410)
            }
            
            if selectedScreen == 1 {
                
                HomeGroupRow(items: appUserData)
                .frame(height: 300)
            }
            
//            ActivityDescriptionView()
//                .background(Color ("SuperLightGray"))
            
        }
//        .edgesIgnoringSafeArea(.all)
        .padding(.vertical, 25)
        .sheet(isPresented: $showingMenu) {
            AppUserDetail(
    appUser: self.items[0]
            )
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreView(
//        items: Array(appUserData.prefix(4))
//        )
//    }
//}
