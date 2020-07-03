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
    @ObservedObject var searchDataContainer: SearchDataContainer
    
    @Binding var isButtonBarHidden: Bool
    @Binding var isSettingsHidden: Bool
    
    @State var selectedEventType: EventType?
    @State var groupList: [Profile] = []
    @State var showInfoTexts = false
    @State var showSubTexts = false
    @State var remainingTime: Int = 0
    @State var tmpValues = TemporaryGroupValues()
    
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
                
                ScrollView(groupList.count == 0 ? [.vertical] : [.vertical], showsIndicators: false) {
                    ScrollViewReader { scrollView in
                        
                        
                        if groupList.count == 0 {
                            
                        HStack(alignment: .center){
                                Text("Finde Gleichgesinnte, gründet Gruppen")
                                    .foregroundColor(Color ("button1"))
                                    .font(.avenirNextRegular(size: 24))
                                    .fontWeight(groupList.count == 0 ? .semibold : .medium)
                                    .padding(.horizontal)
                                    .padding(.vertical) // ist neu
                                    .animation(.spring())
                            
                            Spacer()
                                
                            }
                        .padding(.top, groupList.count == 0 ? 90 : 60)
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

                                if self.searchDataContainer.targetDate > self.searchDataContainer.currentTime {
                                    ExploreProfileView(
                                        searchDataContainer: searchDataContainer,
                                        selectedEventType: $selectedEventType,
                                        groupList: $groupList,
                                        isButtonBarHidden: self.$isButtonBarHidden,
                                        tmpValues: self.$tmpValues
                                    )
                                    .padding(.top, groupList.count == 0 ? 0 : 40)

                                    if groupList.count == 0 {
                                        
                                        
                                        HStack(){
                                            Text("Schließe dich Gruppen an")
                                                .foregroundColor(Color ("button1"))
                                                .font(.avenirNextRegular(size: groupList.count == 0 ? 24 : 20))
                                                .fontWeight(groupList.count == 0 ? .semibold : .medium)
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
                                        
                                        ExploreGroupView(
                                            searchDataContainer: searchDataContainer,
                                            selectedEventType: $selectedEventType,
                                            groupList: $groupList
                                        )
                                        .background(Color ("background1"))
                                    }
                                    
//                                    if self.searchDataContainer.targetDate - self.searchDataContainer.currentTime < 3600 && self.searchDataContainer.targetDate - self.searchDataContainer.currentTime >= 0 {
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
                        searchDataContainer: searchDataContainer,
                        isSettingsHidden: self.$isSettingsHidden)
                        .offset(y: 10)
                    
                    Spacer()
                }
                .offset(y: groupList.count == 0 ? 0 : -150)
            
                if groupList.count != 0  {
                    VStack() {
                        CreateGroupNavigation(
                            selectedEventType: self.$selectedEventType,
                            groupList: self.$groupList,
                            isButtonBarHidden: self.$isButtonBarHidden,
                            tmpValues: self.$tmpValues
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
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var isButtonBarHidden: Bool
    @Binding var tmpValues: TemporaryGroupValues
    
        func deleteGroupList() {
            groupList.removeAll()
            resetGroupValues()
            
            if groupList.count != 0 {
                isButtonBarHidden = true
            } else {
                isButtonBarHidden = false
            }
        }
        
        func resetGroupValues() {
            selectedEventType = nil
            tmpValues.resetGroupValues()
        }
    
    func getActivityString(eventType: EventType) -> String {
        switch eventType {
        case .food:
            return "Essen und Trinken"
        case .activity:
            return "Freizeit"
        case .sport:
            return "Sport"
        }
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
                                    .foreground(gradientCherryPink)
                            }
                            HStack() {
                            Text("\(groupList.count) Personen")
                                .font(.avenirNextRegular(size: 13))
                                .fontWeight(.medium)
                            Text("•")
                                .font(.avenirNextRegular(size: 13))
                                .fontWeight(.medium)
                                
                            if selectedEventType != nil {
                                Text(self.getActivityString(eventType: selectedEventType!))
                                    .font(.avenirNextRegular(size: 13))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color ("button1"))
                            } else {
                                Text("Wähle eine Aktivität aus")
                                    .font(.avenirNextRegular(size: 13))
                                    .fontWeight(.medium)
                                    .foreground(gradientCherryPink)
                            }
                            }
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
        //                        self.searchDataContainer.extendTimer()
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
    //                        .background(Color ("RedPeach"))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .saturation(self.selectedEventType != nil && self.groupList.count != 0 && tmpValues.tmpTitleString != "" ? 1 : 0.2)
                        .opacity(self.selectedEventType != nil && self.groupList.count != 0 && tmpValues.tmpTitleString != "" ? 1 : 0.2)
                        .padding(.horizontal, 20)
//                        .padding(.vertical, 5)

                    }
                    
                }
                .background(Color ("background1"))
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}


final class TemporaryGroupValues: ObservableObject {
    @Published var tmpTitleString: String = ""
    @Published var tmpDescriptionString: String = ""
    @Published var tmpLocationString: String = ""
    @Published var tmpTimeString: String = ""
    @Published var tmpMeetingString: String = ""
    @Published var tmpDateMode: Bool = false
    @Published var groupList: [Profile] = []
    
    func resetGroupValues() {
        tmpTitleString = ""
        tmpDescriptionString = ""
        tmpTimeString = ""
        tmpMeetingString = ""
        tmpLocationString = ""
        tmpDateMode = false
        groupList.removeAll()
    }
}
