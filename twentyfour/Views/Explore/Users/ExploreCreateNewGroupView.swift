//
//  ExploreCreateNewGroupView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 21.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreCreateNewGroupView: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var isFocused = false
    
    @State var keyboardHeight = CGFloat (0)
    @State var showKeyboard = false
    
    @Binding var selectedEventType: EventType?
    @Binding var groupList: [Profile]
    @Binding var tmpTitleString: String
    @Binding var tmpLocationString: String
    @Binding var tmpTimeString: String
    @Binding var tmpMeetingString: String
    
    
     func resetGroupValues() {
        selectedEventType = nil
        tmpTitleString = ""
        tmpTimeString = ""
        tmpMeetingString = ""
        tmpLocationString = ""
        groupList.removeAll()
        showKeyboard = false
        self.presentationMode.wrappedValue.dismiss()
        
     }
    
    func createNewGroup() {
        var group = Group()
        group.title = tmpTitleString
        group.type = selectedEventType
        
        userData.groupList.append(group)
        self.resetGroupValues()
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack() {
//                VStack(){
////                    Buutons
//                    HStack(){
////                        CANCEL BUTTON
//                        Button(action: {
//                            withAnimation(.linear(duration: 0.2)) {
//                                self.presentationMode.wrappedValue.dismiss()
//                            }
//                        }) {
//                            HStack(){
////                                Image(systemName: "xmark")
////                                    .font(.system(size: 20, weight: .medium))
////                                    .frame(width: 36, height: 36)
//                                Text("zurück")
//                                    .font(.avenirNextRegular(size: 16))
//                                    .fontWeight(.semibold)
//                            }
//                        }
//                        .frame(height: 20)
//                        .foregroundColor(Color ("button1"))
//
//                        Spacer()
//
////                        SAFE
//                        if self.tmpTitleString != "" {
//                            Button(action: {
//                                withAnimation(.linear(duration: 0.2)) {
//                                    self.createNewGroup()
//                                }
//                            }) {
//                                HStack(){
//                                    Text("Erstellen")
//                                        .font(.avenirNextRegular(size: 16))
//                                        .fontWeight(.semibold)
//                                    Image(systemName: "arrow.right")
//                                        .font(.system(size: 20, weight: .medium))
//                                        .frame(width: 36, height: 36)
//                                }
//                            }
//                            .frame(height: 20)
//                            .foregroundColor(Color ("button1"))
//                        }
//                    }
//                    .padding(.horizontal, 15)
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                        .background(Color ("background1"))
//                    Spacer()
//                }
//                .offset(y: 10)
                
                // Page
                ScrollView() {
//
                        HStack() {
//                        Spacer()
                            Text("Pflichtangaben")
                                .font(.avenirNextRegular(size: 14))
                                .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)

                    HStack() {
                        Image(systemName: "pencil")
                            .font(.system(size: 14, weight: .medium))
                            .fixedSize()
                            .frame(width: 20, height: 20)

                        VStack(alignment: .leading) {
                            TextField("Titel", text: self.$tmpTitleString)
                                .font(.avenirNextRegular(size: 22))
                                .offset(y: 5)
                                .onTapGesture {
                                    self.isFocused = true
                                }

                        }
                        .padding(.trailing, 40)

                            Spacer()
                        }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)

                    Divider()
                    HStack() {
//                        Spacer()
                            Text("optionale Angaben")
                                .font(.avenirNextRegular(size: 14))
                                .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                        HStack() {
                            Image(systemName: "house")
                            .font(.system(size: 18, weight: .medium))
//                            .foregroundColor(.black)
                            .fixedSize()
                            .frame(width: 20, height: 20)

                            VStack(alignment: .leading) {
                                TextField("Location", text: self.$tmpLocationString)
                                    .font(.avenirNextRegular(size: 22))
                                    .offset(y: 5)
                                    .onTapGesture {
                                        self.isFocused = true
                                    }
                                Divider()
                            }
                            .padding(.trailing, 40)

                                Spacer()
                            }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 10)

                        HStack() {
                                Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 18, weight: .medium))
//                                .foregroundColor(.black)
                                .fixedSize()
                                .frame(width: 20, height: 20)

                            VStack(alignment: .leading) {
                                TextField("Treffpunkt", text: self.$tmpMeetingString)
                                    .font(.avenirNextRegular(size: 22))
                                    .offset(y: 5)
                                    .onTapGesture {
                                        self.isFocused = true
                                    }
                                Divider()
                            }
                            .padding(.trailing, 40)

                                Spacer()
                            }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 10)

                            HStack() {
                                    Image(systemName: "alarm")
                                    .font(.system(size: 18, weight: .medium))
                                    .fixedSize()
                                    .frame(width: 20, height: 20)

                                VStack(alignment: .leading) {
                                    TextField("Zeitpunkt", text: self.$tmpTimeString)
                                        .font(.avenirNextRegular(size: 22))
                                        .offset(y: 5)
                                        .onTapGesture {
                                            self.isFocused = true
                                        }
                                    Divider()
                                }
                                .padding(.trailing, 40)

                                    Spacer()
                                }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
//
//
////                    Divider()
//
//                    // ITO
////                    ExploreCreateNewGroupActivitySection(selectedEventType: self.$selectedEventType)
//
//
////                    HStack(alignment: .bottom )  {
////                        Spacer()
////                            Text("Ausgewählte User")
////                                .font(.avenirNextRegular(size: 20))
////                                .fontWeight(.semibold)
////
////                        Button(action: {
////                            withAnimation(.linear(duration: 0.2)) {
////                                self.presentationMode.wrappedValue.dismiss()
////                            }
////                        }) {
////                            Text("ändern")
////                            .font(.avenirNextRegular(size: 16))
////                        }
////
////                        Spacer()
////                    }
////                    .padding(.horizontal, 20)
////                    .padding(.top, 20)
////
////                    ScrollView(.horizontal, showsIndicators: false) {
////                        HStack(){
////                            ForEach(self.groupList, id: \.self) { profile in
////                                profile.image
////                                .renderingMode(.original)
////                                .resizable()
////                                .scaledToFill()
////                                .clipShape(Circle())
////                                .frame(width: 66 ,height: 66)
////                                    .padding(.trailing, -50)
////                            }
////                        }
////                        .padding(.horizontal, 20)
////                    }
////                    .padding(.bottom, 80)
                }
                .padding(.top, 30)
Spacer()

                    .onAppear() {
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti)  in
                        
                            let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                            let height = value.height
                            
                            self.keyboardHeight = height
                            self.showKeyboard = true
                        }
                        
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti)  in
                            self.keyboardHeight = 0
                            self.showKeyboard = false
                        }
                    }
                .onTapGesture {
                    hideKeyboard()
                }
            }
            
//            HStack(){
//                Spacer()
//                Text("Neue Gruppe")
//                .font(.avenirNextRegular(size: 17))
//                    .fontWeight(.medium)
//                Spacer()
//            }
//            .offset(y: 10)
            
                            if self.showKeyboard == true {
                                VStack(){
                                    Spacer()
                                    HStack(){
                                        Spacer()
                                        // Hide Keyboard
                                        Button(action: {
                                            withAnimation(.linear(duration: 0.2)) {
                                                hideKeyboard()
                                            }
                                        }) {
                                            HStack(){
                                            Image(systemName: "keyboard.chevron.compact.down")
                                                .font(.system(size: 20, weight: .medium))
                                                .frame(width: 36, height: 36)
                                                .padding(.trailing, 10)
                                            }
                                        }
                                        .foregroundColor(.black)

                                        .onAppear() {
                                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti)  in
                                            
                                                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                                                let height = value.height
                                                
                                                self.keyboardHeight = height
                                                self.showKeyboard = true
                                            }
                                            
                                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti)  in
                                                self.keyboardHeight = 0
                                                self.showKeyboard = false
                                            }
                                        }
                                    }
                                    .padding(.top, 10)
                                    .padding(.bottom, 5)
                                    .frame(minWidth: 0, maxWidth: .infinity)
            //                        .padding(self.showKeyboard ? 15 : 15)
                                    .background(BlurView(style: .systemMaterial))
                                }
                                .offset(y: -self.keyboardHeight + 35)
                                .animation(.spring())
            //                    .edgesIgnoringSafeArea(.bottom)
                            }
        }
        .navigationBarHidden(false)
        .navigationBarTitle("Neue Gruppe", displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
    }
}


//struct ExploreCreateNewGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreCreateNewGroupView()
//    }
//}
