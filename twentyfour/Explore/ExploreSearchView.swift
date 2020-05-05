//
//  ExploreSearchView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreSearchView: View {
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
            startPoint: .top,
            endPoint: .bottom)
    }
    
    var gradientColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("RedPeach"),
                    Color ("RedPeach"),
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
                    .pink
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

                Rectangle().fill(Color .clear)
                    .frame(height: 120)
                
                HStack(){
                    Spacer()
                // Button 1
                Button(action: {
                    self.showButtons.toggle()
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
        ExploreSearchView()
    }
}
