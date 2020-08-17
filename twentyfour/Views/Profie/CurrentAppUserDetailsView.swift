//
//  UserDetailsView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 19.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestore

struct ChangeHandler {
    
    var isToggled: Bool = false {
        didSet {
            self.isToggledDidChange.send(isToggled)
        }
    }
    
    var maxDistance: Double = 2 {
        didSet {
            self.maxDistanceDidChange.send(maxDistance)
        }
    }
    
    public let isToggledDidChange = PassthroughSubject<Bool,Never>()
    public let maxDistanceDidChange = PassthroughSubject<Double,Never>()
}


struct CurrentAppUserDetailsView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var defaultMaxDistance: Double = 2
    @State var changeHandler = ChangeHandler()
    
    @Binding var pageIndex: Int
    
    let user = Auth.auth().currentUser
    let currentUser: AppUser
    
    func initSettings() {
        changeHandler.isToggled = ((session.settings?.showInfoTexts) ?? false)
        changeHandler.maxDistance = ((session.userDefaultValues?.maxDistance) ?? 2)
    }
    
    func logOut() {
        self.session.logOut()
        self.pageIndex = 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                ScrollView() {
                    Group {
                        HStack(alignment: .top){
                            VStack(alignment: .leading) {
                                Text("\(session.publicUserData!.username!)")
                                    .font(.avenirNextRegular(size: 28))
                                    .fontWeight(.semibold)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(1)
                                Text("\(session.publicUserData!.userDescription != "" ? session.publicUserData!.userDescription : "Hier könnte eine kleine Beschreibung über dich stehen")")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.light)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(4)
                                
                            }
                            .padding(.trailing, 10)
                            Spacer()
                            currentUser.image
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 90 ,height: 90)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 70)
                        .padding(.bottom, 20)
                        
                        Divider()
                    }
                    
                    Group {
                        HStack() {
                            VStack(alignment: .leading) {
                                Text("Kontaktinfos")
                                    .font(.avenirNextRegular(size: 20))
                                    .fontWeight(.medium)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(1)
                                Text("(nicht für andere sichtbar)")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.light)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        HStack(alignment: .center) {
                            Image(systemName: "envelope")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color ("button1"))
                                .fixedSize()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading) {
                                Text((session.publicUserData?.email)!)
                                    .font(.avenirNextRegular(size: 18))
                                    .fontWeight(.light)
                            }
                            .padding(.trailing, 40)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        
                        Divider()
                    }
                    
                    Group {
                        HStack() {
                            Text("Standard Such-Einstellungen")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.medium)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        HStack(alignment: .top) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color ("button1"))
                                .fixedSize()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading) {
                                Text("max. Enterfernung")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                Text("Hier kann auch etwas Text als Beschreibung stehen")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.light)
                            }
                            .padding(.trailing, 40)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 2)
                        
                        HStack() {
                            Slider(value: self.$changeHandler.maxDistance, in: 2...150, step: 1)
                                .accentColor(.pink)
                        }
                        .padding(.horizontal, 50)
                        .padding(.bottom, 20)
                        
                        Divider()
                    }
                    
                    Group {
                        HStack() {
                            VStack(alignment: .leading) {
                                Text("Interessen")
                                    .font(.avenirNextRegular(size: 20))
                                    .fontWeight(.medium)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(1)
                                Text("(Optional - aber sie helfen für bessere Suchergebnisse)")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.light)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        HStack(alignment: .top) {
                            Image(systemName: "moon.stars")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color ("button1"))
                                .fixedSize()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            
                            VStack(alignment: .leading) {
                                Text("Essen & Trinken")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                Text("Italienisch, Amerikanisch, Französisch, Cocktails, Softdrinks ...")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.light)
                            }
                            .padding(.trailing, 40)
                            
                            Spacer()
                            
                            VStack(){
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color ("button1"))
                                    .fixedSize()
                                    .frame(width: 20, height: 20)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        HStack(alignment: .top) {
                            Image(systemName: "guitars")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color ("button1"))
                                .fixedSize()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            
                            VStack(alignment: .leading) {
                                Text("Freizeit")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                Text("Party, House, Pop, Rock, Kino, Comedy, Horror, Action ...")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.light)
                            }
                            .padding(.trailing, 40)
                            
                            Spacer()
                            
                            VStack(){
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color ("button1"))
                                    .fixedSize()
                                    .frame(width: 20, height: 20)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        HStack(alignment: .top) {
                            Image(systemName: "sportscourt")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color ("button1"))
                                .fixedSize()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            
                            VStack(alignment: .leading) {
                                Text("Sport")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                Text("Laufen, Schwimmen, Fußball, Basketball ...")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.light)
                            }
                            .padding(.trailing, 40)
                            
                            Spacer()
                            
                            VStack(){
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color ("button1"))
                                    .fixedSize()
                                    .frame(width: 20, height: 20)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        
                        Divider()
                    }
                    
                    Group {
                        HStack() {
                            Text("App Einstellungen")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.medium)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        HStack() {
                            
                            Image(systemName: "questionmark")
                                .font(.system(size: 18, weight: .medium))
                                .fixedSize()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color ("button1"))
                                .padding(.trailing, 10)
                            
                            HStack() {
                                VStack(alignment: .leading){
                                    Text("Info-Texte anzeigen")
                                        .font(.avenirNextRegular(size: 16))
                                        .fontWeight(.semibold)
                                    Text("Aktiviere oder Deaktiviere hier die Info-Texte.")
                                        .font(.avenirNextRegular(size: 14))
                                        .fontWeight(.light)
                                }
                                
                                Spacer()
                            }.frame(maxWidth: .infinity)
                            
                            
                            //                            Toggle("", isOn: $userData.showInfoTexts)
                            //                                .labelsHidden()
                            //                                .padding()
                            
                            Toggle("", isOn: ($changeHandler.isToggled))
                                .labelsHidden()
                                .padding()
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Color .pink))
                        .padding(.leading, 20)
                        .padding(.bottom, 20)
                        
                        Divider()
                    }
                    
                    
                    Group {
                        HStack() {
                            VStack(alignment: .leading) {
                                Text("Rechtliches")
                                    .font(.avenirNextRegular(size: 20))
                                    .fontWeight(.medium)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(1)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        HStack(alignment: .top) {
                            Image(systemName: "paragraph")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color ("button1"))
                                .fixedSize()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            
                            VStack(alignment: .leading) {
                                Text("AGB und Nutzungsbedingungen")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                Text("HIer gibt es den Text zu den AGBs bzw. zu den Nutzungsbedingungen")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.light)
                            }
                            .padding(.trailing, 40)
                            
                            Spacer()
                            
                            VStack(){
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color ("button1"))
                                    .fixedSize()
                                    .frame(width: 20, height: 20)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        HStack(alignment: .top) {
                            Image(systemName: "text.justifyleft")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color ("button1"))
                                .fixedSize()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            
                            
                            VStack(alignment: .leading) {
                                Text("Datenschutzhinweise")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                Text("Und hier noch ein paar Infos zum Datenschutz")
                                    .font(.avenirNextRegular(size: 14))
                                    .fontWeight(.light)
                            }
                            .padding(.trailing, 40)
                            
                            Spacer()
                            
                            VStack(){
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color ("button1"))
                                    .fixedSize()
                                    .frame(width: 20, height: 20)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        
                        Divider()
                    }
                    
                    Group {
                        
                        // Abbrechen
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                                self.logOut()
                            }
                        }) {
                            HStack() {
                                Text("Abmelden")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                    .padding(.trailing)
                            }
                            .frame(height: 30)
                            .foreground(gradientPinkPinkAndPeach)
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        
                        // Konto löschen
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                            }
                        }) {
                            HStack() {
                                Text("Konto löschen")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                    .padding(.trailing)
                            }
                            .frame(height: 30)
                            .foregroundColor(Color ("button1"))
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        
                        
                        // User IDs
                        Text("UID: \(user!.uid)")
                            .font(.avenirNextRegular(size: 12))
                            .fontWeight(.light)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(1)
                        Text("PublicUserDataID: \((session.publicUserData?.id)!)")
                            .font(.avenirNextRegular(size: 12))
                            .fontWeight(.light)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(1)
                            
                            .padding(.horizontal, 20)
                            .padding(.bottom, 90)
                    }
                    
                    
                    
                }
                .frame(maxWidth: .infinity)
                
                VStack(){
                    Rectangle().fill(Color ("background1"))
                        .frame(height: geometry.safeAreaInsets.top)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Rectangle().fill(Color ("background1"))
                        .frame(height: geometry.safeAreaInsets.bottom)
                        .frame(maxWidth: .infinity)
                }
                .edgesIgnoringSafeArea(.all)
                //                .edgesIgnoringSafeArea(.top)
                
                //                VStack() {
                //                    HStack() {
                //                        Button(action: {
                //                            withAnimation(.linear(duration: 0.2)) {
                //                                self.presentationMode.wrappedValue.dismiss()
                //                            }
                //                        }) {
                //                            Image(systemName: "chevron.left")
                //                                .font(.system(size: 14, weight: .medium))
                //                                .scaledToFill()
                //                                .frame(width: 45 ,height: 45)
                //                                .background(Color ("background1"))
                //                                .clipShape(Circle())
                //                                .foregroundColor(Color ("button1"))
                //                        }
                //                        .shadow(radius: 4, y: 2)
                //                        .padding(.trailing, 15)
                //                        .padding(.bottom, 15)
                //                        .padding(.top, 10)
                //
                //                        Spacer()
                //                    }
                //                    .padding(.leading, 20)
                //                    Spacer()
                //                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .onAppear(){
                self.initSettings()
            }
            .onReceive(self.changeHandler.isToggledDidChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    if session.settings?.showInfoTexts != newValue {
                        session.settings?.showInfoTexts = newValue
//                        session.settings?.setShowInfoTexts(newValue)
                            session.updateSettings(session.settings!)
                        print("Settings: successfully updated")
                    } else {
                        print("Settings: no update needed")
                    }
                }
            }
            .onReceive(self.changeHandler.maxDistanceDidChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    if session.userDefaultValues?.maxDistance != newValue {
                        session.userDefaultValues?.maxDistance = newValue
                        session.updateUserDefaultValues(session.userDefaultValues!)
                        print("UserDefaultValues: successfully updated")
                    } else {
                        print("UserDefaultValues: no update needed")
                    }
                }
            }
        }
    }
}

//struct UserDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailsView()
//    }
//}
