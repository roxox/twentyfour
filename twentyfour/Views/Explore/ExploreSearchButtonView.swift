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
                                .foregroundColor(.black)
                                .fixedSize()
                                .frame(width: 45, height: 45)
                                .background(gradientGray)
                                .clipShape(Circle())
                        }
                    }
            
                }
                .padding([.leading, .trailing], 20)
        }
        .navigationBarHidden(true)
    }
}
