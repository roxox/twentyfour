//
//  SearchView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 11.05.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var userData: UserData
    
    func closeSearchView() {
        userData.searchViewOffsetY = UIScreen.main.bounds.height
    }
    
    var body: some View {
        VStack(){
            Spacer()
            
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.closeSearchView()
                }
            }) {
                Text("Essen und Trinken")
            }
            .padding()
            
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.closeSearchView()
                }
            }) {
                Text("Freizeit")
            }
            .padding()
            
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.closeSearchView()
                }
            }) {
                Text("Sport")
            }
            .padding()
            
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.closeSearchView()
                }
            }) {
                Text("CLOSE")
            }
            .padding()
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct TypeRow: View {
    
    @EnvironmentObject var userData: UserData
    var eventType: EventType

    var body: some View {
        HStack {
//            landmark.image
//                .resizable()
//                .frame(width: 50, height: 50)
//            Text(landmark.name)
            Spacer()

//            if landmark.isFavorite {
//                Image(systemName: "star.fill")
//                    .imageScale(.medium)
//                    .foregroundColor(.yellow)
//            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
