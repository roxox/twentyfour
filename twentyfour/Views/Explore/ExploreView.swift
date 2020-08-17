//
//  ExploreView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
//import SwiftUIPager

struct ExploreView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData: SearchData
    @EnvironmentObject var session: FirebaseSession
    
    // Editable values
    @State var selectedEventType: ActivityType?
    @State var groupList: [AppUser] = []
    @State var showSubTexts = true
    @State var remainingTime: Int = 0
    @State var tmpValues = TemporaryGroupValues()
    
    
    @State private var favoriteColor = 0
    
    // Bindings
    @Binding var isButtonBarHidden: Bool
    @Binding var showSearch: Bool
    
    
    var items = Array(0..<10)
    @State var page: Int = 0
    
    func secondsToHours (seconds : Int) -> (Int) {
        return (Int(seconds) / 3600)
    }
    
    func secondsToMinutes (seconds : Int) -> (Int) {
        return ((Int(seconds) % 3600) / 60)
    }
    
    func secondsToSeconds (seconds : Int) -> (Int) {
        return ((Int(seconds) % 3600) % 60)
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack() {
                
                VStack(){
                    
                    ScrollView(self.groupList.count == 0 ? [.vertical] : [.vertical], showsIndicators: false) {
                        ScrollViewReader { scrollView in
                            
                            
                            if self.groupList.count == 0 {
                                
                                HStack(alignment: .center){
                                    Text("Finde Gleichgesinnte")
                                        .foregroundColor(Color ("button1"))
//                                        .font(.avenirNextRegular(size: 26))
                                        .font(.coniferous(size: 46))
//                                        .fontWeight(self.groupList.count == 0 ? .semibold : .medium)
                                        .fontWeight(.semibold)
                                        .padding(.horizontal)
                                        .padding(.bottom, 15) // ist neu
                                        .animation(.spring())
                                    
                                    Spacer()
                                    
                                }
//                                .padding(.top, self.groupList.count == 0 ? 90 : 60)
                                .padding(.top, 90)
                                .animation(.spring())
//                        }
                                
                                if showSubTexts {
                                    HStack(){
                                        Text("Finde Gleichgesinnte, gründet Gruppen und unternehmt etwas zusammen")
                                            .foregroundColor(Color ("button1"))
                                            .font(.avenirNextRegular(size: 17))
//                                            .fontWeight(.light)
                                            .lineLimit(5)
                                            .padding(.bottom, 15) // ist neu
                                            .padding(.horizontal)
                                        Spacer()
                                    }
//                                    HStack(){
//
//                                        Button(action: {
//                                            withAnimation(.linear(duration: 0.2)) {
//                                                self.showSubTexts.toggle()
//                                            }
//                                        }) {
//                                            Text("nur Favoriten anzeigen")
//                                                .font(.avenirNextRegular(size: 15))
//                                                .fontWeight(.medium)
//                                        }
//                                        .padding(.horizontal)
//                                        .padding(.bottom)
//
//                                        Spacer()
//                                    }
                                }

                            }
//                            else {
//
//                                HStack(alignment: .center){
//                                    Text("Neue Gruppe")
//                                        .foregroundColor(Color ("button1"))
//                                        .font(.avenirNextRegular(size: 26))
////                                        .fontWeight(self.groupList.count == 0 ? .semibold : .medium)
//                                        .fontWeight(.semibold)
//                                        .padding(.horizontal)
//                                        .padding(.vertical, 5) // ist neu
//                                        .animation(.spring())
//
//                                    Spacer()
//
//                                }
////                                .padding(.top, self.groupList.count == 0 ? 90 : 60)
//                                .padding(.top, 90)
//                                .animation(.spring())
//                            }
            
                            
                            VStack() {
                                Spacer()
                                
                                if self.session.isOwnSearchActive == true {
                                    AppUserListView(
                                        searchData: searchData,
                                        selectedEventType: $selectedEventType,
                                        //                                        groupList: $groupList,
                                        groupList: self.$groupList,
                                        isButtonBarHidden: self.$isButtonBarHidden,
                                        tmpValues: self.$tmpValues
                                    )
                                    .padding(.top, self.groupList.count == 0 ? 0 : 50)
                                    
                                    
//                                        HStack(){
//                                            Spacer()
//                                            Text("leere Gruppe erstellen")
//                                                .foregroundColor(Color ("button1"))
//                                                .font(.avenirNextRegular(size: 16))
////                                                .font(.coniferous(size: 28))
//                                                .underline()
//                                                .fontWeight(self.groupList.count == 0 ? .semibold : .medium)
//                                                .padding(.horizontal)
//                                                .padding(.vertical, 15) // ist neu
//                                                .animation(.spring())
////                                                .background(Color .black)
//                                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
////                                                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(gradientBlueAccentSea, lineWidth: 2))
//                                                .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).stroke(Color .black, lineWidth: 2))
//                                            Spacer()
//                                        }
                                    
//                                    
//                                    Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
//                                        Text("Essen & Trinken").tag(0)
//                                            .font(.avenirNextRegular(size: 16))
//                                        Text("Freizeit").tag(1)
//                                            .font(.avenirNextRegular(size: 16))
//                                        Text("Sport").tag(2)
//                                            .font(.avenirNextRegular(size: 20))
//                                    }
//                                    .pickerStyle(SegmentedPickerStyle())
//                                    .frame(width: UIScreen.main.bounds.width/2)
                                    
                                    if self.groupList.count == 0 {
                                        HStack(){
                                            Text("Schliesse dich Gruppen an")
                                                .foregroundColor(Color ("button1"))
//                                                .font(.avenirNextRegular(size: 26))
                                                .font(.coniferous(size: 40))
                                                .fontWeight(self.groupList.count == 0 ? .semibold : .medium)
                                                .padding(.horizontal)
                                                .padding(.vertical, 15) // ist neu
                                                .animation(.spring())
                                            Spacer()
                                        }
                                        .padding(.top, 15)
                                        
                                        
                                        if showSubTexts {
                                            HStack(){
                                                Text("Lass dich von anderen Gruppen inspirieren und frage an, ob du dich anschließen kannst.")
                                                    .foregroundColor(Color ("button1"))
                                                    .font(.avenirNextRegular(size: 17))
//                                                    .fontWeight(.light)
                                                    .lineLimit(5)
                                                    .padding(.bottom, 5) // ist neu
                                                    .padding(.horizontal)
                                                Spacer()
                                            }
                                            HStack(){
                                                
                                                Button(action: {
                                                    withAnimation(.linear(duration: 0.2)) {
                                                        self.showSubTexts.toggle()
                                                    }
                                                }) {
                                                    Text("nur Favoriten anzeigen")
                                                        .font(.avenirNextRegular(size: 17))
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.black)
                                                        .underline()
                                                }
                                                .padding(.horizontal)
                                                .padding(.bottom, 15)
                                                
                                                Spacer()
                                            }
                                        }
                                        
                                        AppGroupListView()
                                            .background(Color ("background1"))
                                        
                                        // PAGINATION TEST
                                       
                                    }
                                }
                            }
//                            HStack() {
//
//                                Button(action: {
//                                    withAnimation(.linear(duration: 0.2)) {
//                                        self.showSubTexts.toggle()
//                                    }
//                                }) {
//
//                                    Image(systemName: showSubTexts ? "exclamationmark.bubble.fill" : "exclamationmark.bubble")
//                                        .font(.system(size: 22, weight: .semibold))
//                                        .fixedSize()
//                                        .frame(width: 30, height: 30)
//                                        .foregroundColor(Color ("button1"))
//                                }
//                                .padding(.horizontal, 20)
//                                .padding(.bottom, 30)
//                            }
                        }
                    }
                    if self.groupList.count == 0 {
                    Rectangle().fill(Color .clear)
                        .frame(height: 30)
                    }
                }
                .animation(.spring())
                
                VStack(){
                    Rectangle().fill(Color ("background1"))
                        .frame(height: geometry.safeAreaInsets.top)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
                
                VStack() {
                    ExploreSearchButtonView(
                        searchData: searchData,
                        showSearch: self.$showSearch
                    )
                    .offset(y: 10)
                    
                    Spacer()
                }
                .offset(y: self.groupList.count == 0 ? 0 : -150)
                
                if self.groupList.count != 0  {
                    VStack() {
                        CreateGroupNavigation(
                            selectedEventType: self.$selectedEventType,
                            groupList: self.$groupList,
                            isButtonBarHidden: self.$isButtonBarHidden,
                            tmpValues: tmpValues
                        )
                    }
                }
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

//struct ExploreView_Previews: PreviewProvider {
//    @State static var pageIndex_old = 0 // Note: it must be static
//    @State static var pageIndex = 0 // Note: it must be static
////    @State static var groupList = appUserData // Note: it must be static
//    
//    static var previews: some View {
//            let userData = UserData()
//            return ExploreView(
//                items: Array(appUserData.prefix(4)),
//                pageIndex_old: $pageIndex_old,
//                pageIndex: $pageIndex
//            )
//            .environmentObject(userData)
//    }
//}

struct CreateGroupNavigation: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var session: FirebaseSession
    @Binding var selectedEventType: ActivityType?
    @Binding var groupList: [AppUser]
    @Binding var isButtonBarHidden: Bool
    @ObservedObject var tmpValues: TemporaryGroupValues
    
    func deleteGroupList() {
        self.groupList.removeAll()
        resetGroupValues()
        
        if self.groupList.count != 0 {
            isButtonBarHidden = true
        } else {
            isButtonBarHidden = false
        }
    }
    
    func resetGroupValues() {
        selectedEventType = nil
        tmpValues.resetGroupValues()
    }
    
    func getActivityString(eventType: ActivityType) -> String {
        switch eventType {
        case .food:
            return "Essen & Trinken"
        case .leisure:
            return "Freizeit"
        case .sports:
            return "Sport"
        }
    }
    
    func save() {
        var group = AppUserGroup()
        group.title = tmpValues.tmpTitleString
        group.activityType = tmpValues.tmpActivityType
        group.imageName = "sport"
        
        for user in groupList {
            let userIndex = groupList.firstIndex(of: user)
            //            let membership = group.inviteMember(user: &groupList[userIndex!])
            //            groupList[userIndex!].addMembership(membership: membership)
        }
        userData.appGroups.append(group)
        
        let location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        let geopoint = GeoPoint(latitude: 0.0, longitude: 0.0)
        let userGroup = UserGroup(title: tmpValues.tmpTitleString, description: "", location: geopoint, locationPlacemark: "", datemode: false, eventType: .leisure, memberscount: 1)
        session.addUserGroup(group: userGroup)
        
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(){
                VStack(){
                    Rectangle().fill(Color ("background1"))
                        .frame(height: geometry.safeAreaInsets.top)
                    ZStack() {
                        HStack(){
                            Button(action: {
                                self.deleteGroupList()
                            }) {
                                HStack(){
                                    
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 14, weight: .medium))
                                        .frame(width: 18, height: 18)
                                }
                                .frame(height: 36)
                                .foregroundColor(Color ("button1"))
                            }
                            
                            Spacer()
             
                            Text("erstellen")
                                .font(.avenirNextRegular(size: 15))
                                .fontWeight(.bold)
                                .underline()
                        }
                        .padding(.horizontal, 20)
                        
                        //            .padding(.top, 12)
                        HStack(alignment: .center){
                            Spacer()
                            Text("Neue Gruppe")
                                .font(.avenirNextRegular(size: 15))
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
//                    Divider()
                }
                .background(Color ("background1"))
                
                Spacer()
                
                //                HStack() {
                //                    Button(action: {
                //                        withAnimation(.linear(duration: 0.2)) {
                //                            userData.showInfoTexts.toggle()
                //                        }
                //                    }) {
                //                        HStack() {
                //                            Image(systemName: userData.showInfoTexts ? "questionmark.circle.fill" : "questionmark.circle")
                //                                .font(.system(size: 22, weight: .semibold))
                //                                .fixedSize()
                //                                .frame(width: 30, height: 30)
                //                                .foregroundColor(Color ("button1"))
                //                            Text("Infos ausblenden")
                //                                .font(.avenirNextRegular(size: 13))
                //                                .fontWeight(.medium)
                //                                .foregroundColor(Color ("button1"))
                //                        }
                //                        .padding(8)
                //                        .background(BlurView(style: .systemMaterial))
                //                        .clipShape(RoundedRectangle(cornerRadius: 8))
                //                    }
                //                    .padding(.horizontal, 20)
                //                    //                .padding(.bottom, 5)
                //
                //                    Spacer()
                //                }
                
//                VStack() {
//
//                    Divider()
//                    //                    Spacer().foregroundColor(.black).frame(height: 2)
//                    HStack() {
//
////                        VStack(alignment: .leading){
////                            if tmpValues.tmpTitleString != "" {
////                                Text(tmpValues.tmpTitleString)
////                                    .font(.avenirNextRegular(size: 14))
////                                    .fontWeight(.bold)
////                                    .underline()
////                                //                                    .foregroundColor(Color ("button1"))
////                            } else {
////                                Text(tmpValues.tmpTitleString != "" ? tmpValues.tmpTitleString : "Gib der Gruppe einen Titel")
////                                    .font(.avenirNextRegular(size: 14))
////                                    .fontWeight(.bold)
//////                                    .italic()
//////                                    .underline()
////                                //                                    .foreground(selectedEventType == nil ? gradientCherryPink : gradientButton1)
////                            }
////
////                            HStack() {
////                                if selectedEventType == nil {
////                                    Text("Wähle eine Aktivität aus")
////                                        .font(.avenirNextRegular(size: 14))
////                                        .fontWeight(.semibold)
//////                                        .italic()
////                                } else {
////                                    Text("\(self.getActivityString(eventType: selectedEventType!))")
////                                        .font(.avenirNextRegular(size: 14))
////                                        .fontWeight(.semibold)
////                                }
////                            }
////
////                            HStack() {
////                                Text("\(self.groupList.count) \(self.groupList.count == 1 ? "Person wird" : "Personen werden") eingeladen")
////                                    .font(.avenirNextRegular(size: 14))
////                                    .fontWeight(.semibold)
////
////                                //                                    Text("\(selectedEventType == nil ? "Wähle eine Aktivität aus" : self.getActivityString(eventType: selectedEventType!))")
////                                //                                    .font(.avenirNextRegular(size: 14))
////                                //                                    .fontWeight(selectedEventType == nil ? .bold : .semibold)
////                            }
////                        }
////                        .foregroundColor(Color ("button1"))
////                        .padding(.leading, 20)
//
//                        Spacer()
//
//                        Button(action: {
//                            withAnimation(.linear(duration: 0.2)) {
//                                self.save()
//                                //                        self.searchData.extendTimer()
//                            }
//                        }) {
//                            HStack() {
//                                Text("Gruppe erstellen")
//                                    .font(.avenirNextRegular(size: 14))
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal)
//                            }
//                            .frame(height: 40)
//                            .background(gradientCherryPink)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
//                        .saturation(self.selectedEventType != nil && self.groupList.count != 0 && tmpValues.tmpTitleString != "" ? 1 : 0.2)
//                        .opacity(self.selectedEventType != nil && self.groupList.count != 0 && tmpValues.tmpTitleString != "" ? 1 : 0.2)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 10)
//                    }
//                }
//                .background(Color ("background1"))
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}
