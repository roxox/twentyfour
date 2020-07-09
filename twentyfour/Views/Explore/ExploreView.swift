//
//  ExploreView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData: SearchData
    
    // Editable values
    @State var selectedEventType: ActivityType?
    @State var groupList: [AppUser] = []
    @State var showSubTexts = false
    @State var remainingTime: Int = 0
    @State var tmpValues = TemporaryGroupValues()
    
    
    // Bindings
    @Binding var isButtonBarHidden: Bool
    @Binding var showSearch: Bool
    
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
                                    Text("Finde Gleichgesinnte, gründet Gruppen")
                                        .foregroundColor(Color ("button1"))
                                        .font(.avenirNextRegular(size: 24))
                                        .fontWeight(self.groupList.count == 0 ? .semibold : .medium)
                                        .padding(.horizontal)
                                        .padding(.vertical) // ist neu
                                        .animation(.spring())
                                    
                                    Spacer()
                                    
                                }
                                .padding(.top, self.groupList.count == 0 ? 90 : 60)
                                .animation(.spring())
                                
                                
                                if showSubTexts {
                                    HStack(){
                                        Text("Denn zusammen ist man weniger allein")
                                            .foregroundColor(Color ("button1"))
                                            .font(.avenirNextRegular(size: 16))
                                            .fontWeight(.light)
                                            .lineLimit(5)
                                            .padding(.bottom)
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                }
                            }
                            
                            VStack() {
                                Spacer()
                                
                                if self.searchData.targetDate > self.searchData.currentTime {
                                    AppUserListView(
                                        searchData: searchData,
                                        selectedEventType: $selectedEventType,
                                        //                                        groupList: $groupList,
                                        groupList: self.$groupList,
                                        isButtonBarHidden: self.$isButtonBarHidden,
                                        tmpValues: self.$tmpValues
                                    )
                                    .padding(.top, self.groupList.count == 0 ? 0 : 40)
                                    
                                    if self.groupList.count == 0 {
                                        HStack(){
                                            Text("Schließe dich Gruppen an")
                                                .foregroundColor(Color ("button1"))
                                                .font(.avenirNextRegular(size: 24 ))
                                                .fontWeight(.semibold)
                                                .padding(.vertical)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        .padding(.top, 15)
                                        
                                        
                                        if showSubTexts {
                                            HStack(){
                                                Text("Lass dich von anderen Gruppen inspirieren und frage an, ob du dich anschließen kannst.")
                                                    .foregroundColor(Color ("button1"))
                                                    .font(.avenirNextRegular(size: 16))
                                                    .fontWeight(.light)
                                                    .lineLimit(5)
                                                    .frame(height: 50)
                                                    .padding(.horizontal)
                                                Spacer()
                                            }
                                        }
                                        
                                        AppGroupListView()
                                            .background(Color ("background1"))
                                    }
                                    
                                    //                                    if self.searchData.targetDate - self.searchData.currentTime < 3600 && self.searchData.targetDate - self.searchData.currentTime >= 0 {
                                    //
                                    //                                        if secondsToHours(seconds: remainingTime) == 0 && secondsToMinutes(seconds: remainingTime) != 0{
                                    //                                            Text("Aktiv für die nächsten \(secondsToMinutes(seconds: remainingTime)) Minuten")
                                    //                                                    .font(.avenirNextRegular(size: 14))
                                    //                                                    .fontWeight(.semibold)
                                    //                                                    .foreground(gradientPinkBlueAccent)
                                    //                                        } else {
                                    //                                            Text("Suche noch aktiv für die nächsten \(secondsToSeconds(seconds: remainingTime)) Sekunden")
                                    //                                                .font(.avenirNextRegular(size: 14))
                                    //                                                .fontWeight(.semibold)
                                    //                                                .foreground(gradientPinkBlueAccent)
                                    //                                            }
                                    //                                        }
                                }
                            }
                            HStack() {
                                
                                Button(action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        self.showSubTexts.toggle()
                                    }
                                }) {
                                    
                                    Image(systemName: showSubTexts ? "exclamationmark.bubble.fill" : "exclamationmark.bubble")
                                        .font(.system(size: 22, weight: .semibold))
                                        .fixedSize()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(Color ("button1"))
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 30)
                            }
                        }
                    }
                    Rectangle().fill(Color .clear)
                        .frame(height: 30)
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
            return "Essen und Trinken"
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
            let membership = group.inviteMember(user: &groupList[userIndex!])
            groupList[userIndex!].addMembership(membership: membership)
        }
        userData.appGroups.append(group)
        
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
                                        .frame(width: 14, height: 14)
                                }
                                .frame(height: 36)
                                .foregroundColor(Color ("button1"))
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        //            .padding(.top, 12)
                        HStack(alignment: .center){
                            Spacer()
                            Text("Neue Gruppe")
                                .font(.avenirNextRegular(size: 15))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    Divider()
                }
                .background(Color ("background1"))
                
                Spacer()
                
                HStack() {
                    Button(action: {
                        withAnimation(.linear(duration: 0.2)) {
                            userData.showInfoTexts.toggle()
                        }
                    }) {
                        HStack() {
                            Image(systemName: userData.showInfoTexts ? "questionmark.circle.fill" : "questionmark.circle")
                                .font(.system(size: 22, weight: .semibold))
                                .fixedSize()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color ("button1"))
                            Text("Infos ausblenden")
                                .font(.avenirNextRegular(size: 13))
                                .fontWeight(.medium)
                                .foregroundColor(Color ("button1"))
                        }
                        .padding(8)
                        .background(BlurView(style: .systemMaterial))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(.horizontal, 20)
                    //                .padding(.bottom, 5)
                    
                    Spacer()
                }
                
                VStack() {
                    
                    Divider()
                    
                    HStack() {
                        
                        VStack(alignment: .leading){
                            if tmpValues.tmpTitleString != "" {
                                Text(tmpValues.tmpTitleString)
                                    .font(.avenirNextRegular(size: 13))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color ("button1"))
                            } else {
                                Text(tmpValues.tmpTitleString != "" ? tmpValues.tmpTitleString : "Gib der Gruppe noch einen Titel")
                                    .font(.avenirNextRegular(size: 13))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color .pink)
                            }
                            HStack() {
                                Text("\(self.groupList.count) Personen  •  ")
                                    .font(.avenirNextRegular(size: 13))
                                    .fontWeight(.medium) +
                                    
                                    Text("\(selectedEventType == nil ? "Wähle eine Aktivität aus" : self.getActivityString(eventType: selectedEventType!))")
                                    .font(.avenirNextRegular(size: 13))
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedEventType == nil ? .pink : Color ("button1"))
                            }
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                                self.save()
                                //                        self.searchData.extendTimer()
                            }
                        }) {
                            HStack() {
                                Text("erstellen")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                            }
                            .frame(height: 40)
                            .background(gradientPeachPink)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .saturation(self.selectedEventType != nil && self.groupList.count != 0 && tmpValues.tmpTitleString != "" ? 1 : 0.2)
                        .opacity(self.selectedEventType != nil && self.groupList.count != 0 && tmpValues.tmpTitleString != "" ? 1 : 0.2)
                        .padding(.horizontal, 20)
                        
                    }
                    
                }
                .background(Color ("background1"))
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}
