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

struct ExploreSearchButtonView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
    
    @State var showButtons = false
    @State var selectedScreen = 0
    
    
    
    func logout() {
        hideKeyboard()
//        self.isLoading = true
        
        try! Auth.auth().signOut()
        userData.isLogged = false
    }
    
    func openSearchView() {
//        searchDataContainer.copyValuesToTmpValues()
        userData.searchViewOffsetY = CGFloat (0)
    }
    
    var body: some View {
        
            ZStack(alignment: .top) {

                Rectangle().fill(Color .clear)
                    .frame(height: 120)
                
                HStack(alignment: .top){
                    
//                    userData.currentUser.image
//                    .renderingMode(.original)
//                    .resizable()
//                    .scaledToFill()
//                    .clipShape(Circle())
////                        .overlay(Circle().stroke(Color .black, lineWidth: 1))
//                    .frame(width: 45 ,height: 45)
//                        .shadow(radius: 5)
                        
                    Spacer()
                    
                    // SearchButton
                    Button(action: {
                        withAnimation(.linear(duration: 0.2)) {
                            self.openSearchView()
                        }
                    }) {
                        HStack() {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 22, weight: .medium))
                                .fixedSize()
                                .frame(width: 24, height: 40)
//                                .background(gradientGray)
                            Text("Suche anpassen")
                            .font(.avenirNextRegular(size: 16))
                            .fontWeight(.medium)
                        }
                        .padding(.horizontal, 10)
                        .background(Color ("background1"))
                        .foregroundColor(Color ("button1"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 4, y: 2)
                    }
                    Spacer()
            
                }
                .padding([.leading, .trailing], 20)
        }
        .navigationBarHidden(true)
    }
}
