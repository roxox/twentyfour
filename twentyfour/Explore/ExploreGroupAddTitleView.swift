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
    
    @Binding var tabBarIndex: Int
    @Binding var groupList: [Profile]
    @Binding var screenLock: Bool
    @Binding var selectedEventType: EventType?
    
    @State private var title: String  = ""
    @State private var description: String = ""
    @State private var showTextFieldView = false
    @State private var showDescriptionFieldView = false
    
    @State var offsetValue = CGFloat (0)
    
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
    
    func backToCreateToGroup() {
        UIApplication.shared.endEditing()
        userData.createGroupMenuOffsetX = 0
        userData.addTitleMenuOffsetX = CGFloat (-UIScreen.main.bounds.width)
    }

    func resetValues() {
        groupList.removeAll()
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
        
        
        for profile in groupList {
            userData.appUsers[userData.appUsers.firstIndex(of: profile)!].groups.append(newGroup)
        }

        for profile in userData.appUsers {
            let localProfile = userData.appUsers[userData.appUsers.firstIndex(of: profile)!]
            print("User: \(localProfile.username); Number of Groups: \(localProfile.groups.count)")
        }
        
        
        resetValues()
        
        userData.createGroupMenuOffsetX = 0
        userData.addTitleMenuOffsetX = CGFloat (-UIScreen.main.bounds.width)
        
        userData.createGroupMenuOffsetY = CGFloat (700)
        userData.buttonBarOffset = CGFloat (0)
        tabBarIndex = 1
    }
    
    func resetGroupValues() {
            selectedEventType = nil
    }
    
    func deleteGroupList() {
        groupList.removeAll()
        resetGroupValues()
        
        UIApplication.shared.endEditing()
        if groupList.count != 0 {
            userData.createGroupMenuOffsetY = CGFloat (0)
            userData.buttonBarOffset = CGFloat (100)
            screenLock = true
        } else {
            userData.createGroupMenuOffsetY = CGFloat (555)
            userData.buttonBarOffset = CGFloat (0)
            screenLock = false
        }
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
                    
                    TextField("Schreibe mehr über das was du vor hast.", text: $title)
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
                .shadow(radius: 30, y: 10)
        }
        .offset(y: -self.offsetValue).animation(.spring())
        .onAppear() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti)  in
            
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                
                self.offsetValue = height+60
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti)  in
                
                self.offsetValue = 0
            }
                
                
        }
    }

}

struct TitleTextFieldView: View {
    
    @Binding var showTextFieldView : Bool
    @Binding var title: String
    
    var body: some View {
        VStack() {
            
            HStack() {
                Text("Titel")
                        .font(.avenirNextRegular(size: 20))
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 20)
                        .lineLimit(1)
//                        .padding(20)
                Spacer()
            }
                           
            HStack() {
                CustomTextField(text: $title, isFirstResponder: true)
                        .font(.avenirNextRegular(size: 20))
                        .padding(.horizontal, 5)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                        .background(Color ("SuperLightGray"))
                        .cornerRadius(8)
            }
            
             Button(action: {
                self.showTextFieldView = false
            }) {
                Text("zurück")
                .font(.avenirNextRegular(size: 18))
                .fontWeight(.semibold)
            }
            Spacer()
        }
        .padding(20)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct DescriptionTextFieldView: View {
    
    @Binding var showDescriptionFieldView : Bool
    @Binding var description: String
    
    var body: some View {
        VStack() {
            
            HStack() {
                Text("Beschreibung")
                        .font(.avenirNextRegular(size: 20))
                        .fontWeight(.semibold)
                        .fixedSize(horizontal: true, vertical: true)
                        .padding(.horizontal, 20)
                        .lineLimit(1)
//                        .padding(20)
                Spacer()
            }
                           
            HStack(alignment: .top) {
                CustomTextField(text: $description, isFirstResponder: true)
                        .font(.avenirNextRegular(size: 20))
                        .fixedSize(horizontal: true, vertical: true)
                        .padding(.horizontal, 5)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                        .background(Color ("SuperLightGray"))
                        .cornerRadius(8)
                        .lineLimit(4)
            }
            
            
            HStack() {
                Button(action: {
                    self.showDescriptionFieldView = false
                    }) {
                        Text("zurück")
                        .font(.avenirNextRegular(size: 18))
                        .fontWeight(.semibold)
                    }
            }
            Spacer()
        }
        .padding(20)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

//struct ExploreGroupAddTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreGroupAddTitleView()
//    }
//}
