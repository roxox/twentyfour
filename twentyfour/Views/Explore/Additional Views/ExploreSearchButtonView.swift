//
//  ExploreSearchView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Firebase

var gradientCherryPink: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
            [
                Color ("Cherry"),
                .pink,
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

var gradientGrasOldGras: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
            [
                Color ("gras"),
                Color ("old_gras"),
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

struct ExploreSearchButtonView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData: SearchData
    @EnvironmentObject var session: FirebaseSession
    
    @Binding var showSearch: Bool
    
    @State var showButtons = false
    @State var selectedScreen = 0
    @State private var favoriteColor = 0
    
    
    
    func logout() {
        hideKeyboard()
//        self.isLoading = true
        
        try! Auth.auth().signOut()
        userData.isLogged = false
    }
    
    func openSearchView() {
        session.getLastActiveOwnSearch { search in
            print("\(search?.id)")
            self.showSearch.toggle()
        }
//        self.showSearch.toggle()
    }
    
    var body: some View {
        
            ZStack(alignment: .top) {

                Rectangle().fill(Color .clear)
                    .frame(height: 80)
                
                HStack(alignment: .top){
                                            
//                    Spacer()
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.2)) {
                            self.openSearchView()
                        }
                    }) {
                        HStack() {
                            Text("Essen & Trinken")
                            .font(.avenirNextRegular(size: 13))
                            .fontWeight(.bold)
                                .frame(height: 45)
                                .padding(.horizontal, 15)
                            
                        }
                        .padding(.horizontal, 5)
                        .background(Color .black)
                        .foregroundColor(Color .white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .shadow(radius: 2, y: 1)
                        .padding(.top, 20)
                        .padding(.leading, 9)
                    }
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.2)) {
                            self.openSearchView()
                        }
                    }) {
                        HStack() {
                            Text("Freizeit")
                            .font(.avenirNextRegular(size: 13))
                            .fontWeight(.bold)
                                .frame(height: 45)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 5)
                        .background(Color ("background3"))
                        .foregroundColor(Color ("button1"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .shadow(radius: 2, y: 1)
                        .padding(.top, 20)
                    }
                    
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.2)) {
                            self.openSearchView()
                        }
                    }) {
                        HStack() {
                            Text("Sport")
                            .font(.avenirNextRegular(size: 13))
                            .fontWeight(.bold)
                                .frame(height: 45)
                                .padding(.horizontal, 15)
                        }
                        .padding(.horizontal, 5)
                        .background(Color ("background3"))
                        .foregroundColor(Color ("button1"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .shadow(radius: 2, y: 1)
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.2)) {
                            self.openSearchView()
                        }
                    }) {
                        HStack() {
                            Image(systemName: "slider.horizontal.3")
                                .font(.system(size: 22, weight: .medium))
                                .fixedSize()
                                .frame(width: 24, height: 41)
//                            Text("Suche anpassen")
//                            .font(.avenirNextRegular(size: 16))
//                            .fontWeight(.medium)
//                                .padding(.trailing, 5)
                        }
                        .padding(.horizontal, 10)
//                        .background(Color ("background3"))
                        .foregroundColor(Color ("button1"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .shadow(radius: 2, y: 1)
                        .padding(.top, 20)
                        .padding(.trailing, 9)
                    }
                    
                    
                    
//                    Spacer()
            
                }
                .padding([.leading, .trailing], 10)
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}
