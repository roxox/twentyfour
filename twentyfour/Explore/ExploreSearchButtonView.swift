//
//  ExploreSearchView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreSearchButtonView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var showButtons = false
    @State var selectedScreen = 0
    
        
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
    
    func openSearchView() {
        userData.searchViewOffsetY = CGFloat (0)
    }
    
    var body: some View {
        
            ZStack(alignment: .top) {

                Rectangle().fill(Color .clear)
                    .frame(height: 120)
                
                HStack(){
                    Spacer()
                // Button 1
                Button(action: {
                    withAnimation(.linear(duration: 0.2)) {
                        self.openSearchView()
                    }
                }) {
                    HStack() {
                        
                        Text("Suche ändern")
                            .font(.avenirNextRegular(size: 16))
                            .fontWeight(.semibold)
                            .fixedSize()
                            .truncationMode(.head)
                        
                        Image(systemName: "chevron.down")
                            .font(.headline)
                            .fixedSize()
                    }
                    .foreground(Color("DarkGray"))
                    
                }
                .fixedSize()
                .frame(height: 46)
                    .padding(.horizontal)
                    .background(gradientGray)
                .cornerRadius(23.0)
            
            Spacer()
                }
//                .padding([.leading, .trailing], 20)
//                .padding([.top], 60)
        }
        .navigationBarHidden(true)
    }
}

struct ExploreSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreSearchButtonView()
    }
}
