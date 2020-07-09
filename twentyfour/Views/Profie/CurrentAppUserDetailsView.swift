//
//  UserDetailsView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 19.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct CurrentAppUserDetailsView: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showInfoTexts: Bool = false
    @State var defaultMaxDistance: Double = 2
    
    let currentUser: AppUser
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                ScrollView() {
                    Group {
                        HStack(alignment: .top){
                            VStack(alignment: .leading) {
                                Text(currentUser.username)
                                    .font(.avenirNextRegular(size: 28))
                                    .fontWeight(.semibold)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(1)
                                Text("Hier könnte eine kleine Beschreibung über dich stehen. Klicke auf Bearbeiten, um eine zu erstellen")
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
                                Text(currentUser.email)
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
                            Slider(value: self.$defaultMaxDistance, in: 2...150, step: 1)
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
                                Text("Essen und Trinken")
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
                            
                            Toggle("", isOn: $userData.showInfoTexts)
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
        }
    }
}

//struct UserDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailsView()
//    }
//}
