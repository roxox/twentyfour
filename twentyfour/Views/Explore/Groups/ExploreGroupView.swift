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

struct ExploreGroupView: View {
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
     
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    
    @State var showProfile = false
    

  
    
//    func addToGroupList(profile: Profile) {
//        if !groupList.contains(profile) {
//            groupList.append(profile)
//        }
//    }
    
//    func removeFromGroupList(profile: Profile) {
//        if groupList.contains(profile) {
//            groupList.remove(at: groupList.firstIndex(of: profile)!)
//        }
//    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
    
    var body: some View {
        VStack() {
//        if self.searchData.isSearchActive == true {
//            Text("Hallo")
//        }
            
                HStack(){
                    Text("Schließe dich Gruppen an")
//                        .foregroundColor(Color ("button1"))
                        .foregroundColor(Color ("button1_inverted"))
                        .font(.avenirNextRegular(size: 20))
                        .fontWeight(.medium)
                        .padding(.top)
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.top, 30)
            
                HStack(){
                    Text("Lass dich von anderen Gruppen inspirieren und frage an, ob du dich anschließen kannst.")
//                        .foregroundColor(Color ("button1"))
                        .foregroundColor(Color ("button1_inverted"))
                        .font(.avenirNextRegular(size: 16))
                        .fontWeight(.light)
                        .lineLimit(5)
                        .frame(height: 60)
//                        .padding(.bottom)
                        .padding(.horizontal)
                    Spacer()
                }
            
            
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {

                ForEach(userData.appGroups) { group in
                    GeometryReader { geometry in
                        
                        
                        NavigationLink(
                            destination: GroupDetail()

                        ) {
                            GroupRowItem(
                                group: group,
                                selectedEventType: self.$selectedEventType,
                                groupList: self.$groupList,
                                showProfile: self.$showProfile
                            )
                        }
                        .buttonStyle(BorderlessButtonStyle())
//                        .foregroundColor(Color ("button1"))
//                        .disabled(self.selectedEventType == nil || self.groupList.count == 0)
                        
                        
//                        GroupRowItem(
//                            group: group,
//                            selectedEventType: self.$selectedEventType,
//                            groupList: self.$groupList,
//                            showProfile: self.$showProfile
//                        )
//                            .rotation3DEffect(Angle(degrees:
//                                (Double(geometry.frame(in: .global).minX)) / -65
//                            ), axis: (x:0, y:10, z:0))
                    }
                    .frame(width: 330, height: 280)
                }
            }
            .padding(.bottom, 60)
        }
//        .animation(.spring())
        Spacer()
        }
    }
}

struct GroupRowItem: View {
    var group: Group
    @State var deviceWidth = UIScreen.main.bounds.width - 20
    @State var deviceHeight = UIScreen.main.bounds.height - 300
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    
    var body: some View {
            VStack(alignment: .leading) {
                self.group.image
//                Image("sport")
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width*0.74 ,height: UIScreen.main.bounds.width*0.56)
//                    .frame(width: UIScreen.main.bounds.width*0.73 ,height: UIScreen.main.bounds.width*0.74)
                    .overlay(GroupOverlay(
                        currentGroup: self.group,
                        selectedEventType: self.$selectedEventType,
                        groupList: self.$groupList,
                        showProfile: $showProfile
                        )
                )
                .cornerRadius(10)
//                .shadow(color: .init(red: 0.5, green: 0.5, blue: 0.5)
//                , radius: 9, x: 0, y: 4)
            }
//        .padding(10)
    }
}

struct GroupOverlay: View {
    
    @EnvironmentObject var userData: UserData
    
    var currentGroup: Group
    @Binding var selectedEventType: EventType?
    
    @State var tempUser: Profile?
    @State var showInfoPanel: Bool = true
    @State var collapsedOffset: Int = 290
    
    @Binding var groupList: [Profile]
    @Binding var showProfile: Bool
    
    @State var showCard = false
    @State var userId: String = String()
    
    func resetGroupValues() {
            selectedEventType = nil
    }
    
    func getType(typeToTest: EventType) -> String{
        if typeToTest == .food {
            return "Essen und Trinken"
        }
        if typeToTest == .activity {
            return "Freizeit"
        }
        if typeToTest == .sport {
            return "Sport"
        }
        
        return ""
    }
    
    var body: some View {

        GeometryReader { geometry in
        ZStack(alignment: .bottomLeading) {
            
            // Black Overlay
            VStack() {
                
                Spacer()
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text(self.currentGroup.title!)
                            .foregroundColor(Color ("button1_inverted"))
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.horizontal)
                        Text("Albertos Pizzeria, Los Angeles")
                            .foregroundColor(Color ("button1_inverted"))
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.light)
                            .padding(.horizontal)
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/3.3)
//                    .background(Color ("background1_inverted"))
                    .background(Color ("background4"))
            }
            
            }
        }
    }
}

