//
//  ExploreGroupAddTitleView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 06.05.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import UIKit

struct ExploreGroupAddTitleView: View {
    
    @EnvironmentObject var userData: UserData
    
    @Binding var pageIndex: Int
//    @Binding var groupList: [Profile]
    @Binding var screenLock: Bool
    @Binding var selectedEventType: EventType?
    @Binding var isMenuMinimized: Bool
    @Binding var isMenuCollapsed: Bool
    
    @State private var title: String  = ""
    @State private var description: String = ""
    @State private var showTextFieldView = false
    @State private var showDescriptionFieldView = false
    
    @State var offsetValue = CGFloat (0)
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    func backToCreateToGroup() {
        UIApplication.shared.endEditing()
        userData.createGroupMenuOffsetX = menuIn
        userData.addTitleMenuOffsetX = menuLeftOut
    }

    func resetValues() {
        userData.groupList.removeAll()
        screenLock = false
        selectedEventType = nil
    }
    
    func createGroup() {
        UIApplication.shared.endEditing()
        var newGroup: Group = Group()
        newGroup.id = title
    
        
        
        userData.currentUser.groups.append(newGroup)
        
//        newGroup.administrators!.append(user)
        print(userData.currentUser.groups.count)
        
        
        for profile in userData.groupList {
            userData.appUsers[userData.appUsers.firstIndex(of: profile)!].groups.append(newGroup)
        }

        for profile in userData.appUsers {
            let localProfile = userData.appUsers[userData.appUsers.firstIndex(of: profile)!]
            print("User: \(localProfile.username); Number of Groups: \(localProfile.groups.count)")
        }
        
        
        resetValues()
        
        userData.createGroupMenuOffsetX = menuIn
        userData.addTitleMenuOffsetX = menuLeftOut
        
        isMenuCollapsed = true
        isMenuMinimized = false
//        userData.createGroupMenuOffsetY = menuCollapsed
        userData.buttonBarOffset = CGFloat (0)
        pageIndex = 1
    }
    
    func resetGroupValues() {
        selectedEventType = nil
        title = ""
        description = ""
    }
    
    func deleteGroupList() {
        userData.groupList.removeAll()
        resetGroupValues()
        
        UIApplication.shared.endEditing()
        
        if userData.groupList.count != 0 {

            isMenuCollapsed = false
            isMenuMinimized = false
//            userData.createGroupMenuOffsetY = menuExpanded
            userData.buttonBarOffset = CGFloat (100)
            screenLock = true
        } else {

            isMenuCollapsed = false
            isMenuMinimized = true
//            userData.createGroupMenuOffsetY = menuMinimized3
            userData.buttonBarOffset = CGFloat (0)
            screenLock = false
        }
        
        userData.createGroupMenuOffsetX = menuIn
        userData.addTitleMenuOffsetX = menuLeftOut
    }
    
    var body: some View {

        VStack() {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack() {
                    VStack(alignment: .leading) {
                        Text("Titel")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)

                        Text("(max. 80 Zeichen)")
                                .font(.avenirNextRegular(size: 12))
                                .fontWeight(.light)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
                    }
//                    .padding(.bottom, 10)
                    Spacer()
                    Button(action: {
                        self.deleteGroupList()
                    }) {
                        Image(systemName: "trash")
                            .font(.avenirNextRegular(size: 16))
                            .frame(width: 40 ,height:40)
                            .background(Color .pink)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
                               
                HStack() {

                    
                    TextField("z.B. Essen gehen ", text: $title)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.bottom, 20)
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text("Beschreibung")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)

                        Text("(max. 300 Zeichen)")
                                .font(.avenirNextRegular(size: 12))
                                .fontWeight(.light)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
                    }
                    .padding(.bottom, 10)
                        
                    Spacer()
                }
//                .padding(.bottom, 20)
                               
                HStack() {
                    
                    TextField("Schreibe mehr über das was du vor hast.", text: $description)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.bottom, 20)
            
                HStack() {
                    Button(action: {
                        self.backToCreateToGroup()
                    }) {
                        Text("zurück")
                        .font(.avenirNextRegular(size: 18))
                        .fontWeight(.semibold)
                    }

                    Spacer()
                    
                    Button(action: {
                        self.createGroup()
                    }) {
                        Text("weiter")
                        .font(.avenirNextRegular(size: 18))
                        .fontWeight(.semibold)
                    }
                }
            }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.bottom, 30)
                .padding([.top, .leading, .trailing], 20)
                .background(Color .white)
                .transition(.move(edge: .top))
                .cornerRadius(15)
//                .shadow(radius: 30, y: 10)
        }
        .edgesIgnoringSafeArea(.bottom)
        .offset(y: -self.offsetValue).animation(.spring())
        .onAppear() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti)  in
            
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                
                self.offsetValue = height-60
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti)  in
                
                self.offsetValue = 0
            }
        }
    }

}
