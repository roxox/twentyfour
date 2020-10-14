//
//  ButtonBarView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 20.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ButtonBarView: View {
    
    @Binding var pageIndex: Int
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            VStack(alignment: .leading) {
                Divider()
                HStack() {
                    Spacer()
                    
                    // Lupe
                    Button(action: {
                        self.pageIndex = 0
                    }) {
                        VStack() {
                            
                            Image(systemName: "magnifyingglass")
                                .padding(.vertical, 10.0)
                                .font(.system(size: 20, weight: pageIndex == 0 ? .bold : .semibold))
                                .frame(width: 40, height: 24)
//                                .foreground(pageIndex == 0 ? gradientCherryPink : gradientAlmostBlack)
//                                .foreground(pageIndex == 0 ? Color ("old_gras") : Color ("dark_gray"))
                                .foreground(pageIndex == 0 ? gradientGrasOldGras : gradientAlmostBlack)
//                                gradientGrasOldGras
                                .offset(x: 0, y: 0)
                            
                            Text("Stöbern")
                                .font(.avenirNextRegular(size: 11))
                                .fontWeight(.semibold)
//                                .foreground(pageIndex == 0 ? gradientCherryPink : gradientAlmostBlack)
//                                .foreground(pageIndex == 0 ? Color ("old_gras") : Color ("dark_gray"))
                                .foreground(pageIndex == 0 ? gradientGrasOldGras : gradientAlmostBlack)
                        }
                    }
                    
                    Spacer()
                    
                    //                  Button My Groups
                    Button(action: {
                        self.pageIndex = 1
                    }) {
                        VStack() {
                            
                            Image(systemName: "person.3")
                                //                            .padding(.vertical, 10.0)
                                .font(.system(size: 20, weight: pageIndex == 1 ? .bold : .semibold))
                                .frame(width: 40, height: 24)
                                .foreground(pageIndex == 1 ? gradientCherryPink : gradientAlmostBlack)
                                .offset(x: 0, y: 0)
                            
                            Text("Meine Gruppen")
                                .font(.avenirNextRegular(size: 11))
                                .fontWeight(.semibold)
                                .foreground(pageIndex == 1 ? gradientCherryPink : gradientAlmostBlack)
                        }
                    }
                    
                    Spacer()
                    
                    //                  Button Message
                    Button(action: {
                        self.pageIndex = 2
                    }) {
                        VStack() {
                            Image(systemName: "bubble.left")
                                .padding(.vertical, 10.0)
                                .font(.system(size: 20, weight: pageIndex == 2 ? .bold : .semibold))
                                .frame(width: 40, height: 24)
                                .foreground(pageIndex == 2 ? gradientCherryPink : gradientAlmostBlack)
                                .offset(x: 0, y: 0)
                            
                            Text("Nachrichten")
                                .font(.avenirNextRegular(size: 11))
                                .fontWeight(.semibold)
                                .foreground(pageIndex == 2 ? gradientCherryPink : gradientAlmostBlack)
                        }
                    }
                    
                    Spacer()
                    
                    //                  Button Profil
                    Button(action: {
                        self.pageIndex = 3
                    }) {
                        VStack() {
                            Image(systemName: "person")
                                .padding(.vertical, 10.0)
                                .font(.system(size: 20, weight: pageIndex == 3 ? .bold : .semibold))
                                .frame(width: 40, height: 24)
                                .foreground(pageIndex == 3 ? gradientCherryPink : gradientAlmostBlack)
                                .offset(x: 0, y: 0)
                            
                            Text("Profil")
                                .font(.avenirNextRegular(size: 11))
                                .fontWeight(.semibold)
                                .foreground(pageIndex == 3 ? gradientCherryPink : gradientAlmostBlack)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 10)
            }
//            .background(Color ("background_new"))
        }
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

//struct ButtonBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonBarView()
//    }
//}
