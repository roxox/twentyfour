//
//  HomeProfileView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import UIKit
//import Combine

struct AppGroupListView: View {
    @EnvironmentObject var userData: UserData
    
    @State var showProfile = false
    
    var body: some View {
        VStack() {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    
                    ForEach(userData.appGroups) { group in
                        GeometryReader { geometry in
                            
                            
                            NavigationLink(
                                destination: UserGroupDetail(
                                    currentUserGroup: group
                                )
                                
                            ) {
                                AppGroupListItem(
                                    group: group,
//                                    groupList: self.$groupList,
                                    showProfile: self.$showProfile
                                )
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                        }
                        .frame(width: 320, height: 260)
                    }
                }
                .padding(.bottom, 60)
            }
            
            Spacer()
        }
    }
}

struct AppGroupListItem: View {
    var group: AppUserGroup
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            self.group.image
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*0.74 ,height: UIScreen.main.bounds.width*0.48)
//                .frame(width: UIScreen.main.bounds.width*1 ,height: UIScreen.main.bounds.width*0.48)
                
                .cornerRadius(8)
//                .shadow(radius: 4, y: 2)
            
            HStack() {
                VStack(alignment: .leading) {
                    Text(self.group.title!)
                        .foregroundColor(Color ("button1_inverted"))
                        .font(.avenirNextRegular(size: 18))
//                        .padding(.bottom, 1)
                        .padding(.top, 1)
                        .padding(.horizontal, 2)
//                        .fontWeight(.medium)
                    Text("Albertos Pizzeria, Los Angeles")
                        .foregroundColor(Color ("button1_inverted"))
                        .font(.avenirNextRegular(size: 18))
                        .padding(.horizontal, 2)
                        .offset(y: 2)
//                        .padding(.top, 1)
//                        .fontWeight(.medium)
//                    Text("\(group.memberships!.count) Personen nehmen teil")
//                        .foregroundColor(Color ("button1"))
//                        .font(.avenirNextRegular(size: 16))
//                        .fontWeight(.light)
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }
        
        .padding(10)
    }
}

