//
//  ExploreNoSearchView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 15.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreNoSearchView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
    
    func openSearchView() {
        searchDataContainer.resetValues()
        
        searchDataContainer.eventTypes.removeAll()
        searchDataContainer.locationString = ""
        userData.resetValues()
        
        userData.searchViewOffsetY = CGFloat (0)
    }
    
    var body: some View {
        VStack(){
            Spacer()
                
            HStack() {
                Text("Zur Zeit bist du nicht auf der Suche")
                    .font(.avenirNextRegular(size: 20))
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 20)
                
            HStack() {
                Text("Um andere User zu finden und um gleichzeitig von ihnen gefunden zu werden, musst du eine aktive Suche erstellt haben.")
                    .font(.avenirNextRegular(size: 14))
                    .fontWeight(.light)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .padding(.top, 10)
            
            
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
//                                .background(gradientGray)
                        Text("Suche erstellen")
                            .padding(.trailing)
                    }
                    .frame(height: 46)
                    .foreground(gradientPinkBlueAccent)
//                    .foreground(gradientPinkVioletBlueAccent)
//                    .background(gradientGray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(gradientPinkBlueAccent, lineWidth: 2)
                    )
                }
                
                Spacer()
        
            }
            .padding([.leading, .trailing], 20)
            
            Spacer()
        }
//        .frame(height: UIScreen.main.bounds.height)
    }
}

//struct ExploreNoSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreNoSearchView()
//    }
//}
