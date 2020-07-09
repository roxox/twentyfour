//
//  UserDetailsViewer.swift
//  twentyfour
//
//  Created by Sebastian Fox on 19.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct AppUserProfileView: View {
        let user: AppUser
        @Binding var showCard : Bool
        
        var body: some View {
            VStack() {
                HStack() {
                    Button(action: {
    //                    withAnimation(.linear(duration: 0.2)) {
                        self.showCard.toggle()
    //                        self.removeFromGroupList(profile: profile)
    //                    }
                    }) {
                        HStack() {
                            Image(systemName: "xmark")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.black)
                                .fixedSize()
                                .frame(width: 45, height: 45)
                                .padding(.leading, 10)
                    }
                    
                        Spacer()
                    }
                    .padding(.top, 10)
                }
                CurrentAppUserDetailsView(currentUser: user)
            }
        }
    }

//struct UserDetailsViewer_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailsViewer()
//    }
//}
