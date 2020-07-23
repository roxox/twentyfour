//
//  UserGroupDetail.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.05.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct UserGroupDetail: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let currentUserGroup: AppUserGroup
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                ScrollView() {
                    
                    // Bild
                    currentUserGroup.image
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                    
                    // Titel
                    HStack() {
                        Text(currentUserGroup.title!)
                            .font(.avenirNextRegular(size: 20))
                            .fontWeight(.medium)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Divider()
                    
                    Group {
                        HStack() {
                            Text("Bestätigte Teilnehmer")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.medium)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        Divider()
                    }
//                    Group {
//                        
//                        ForEach(currentUserGroup.invitedMembers, id: \.self) { member in
//                            Text("\(member.user.username)")
//                        }
//                    }
                    
                    Group {
                        HStack() {
                            Text("Offene Anfragen")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.medium)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        Divider()
                    }
                    
                    Group {
                        HStack() {
                            Text("Gruppenchat")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.medium)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        Divider()
                    }
                    
                    
                }
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.top)
                
                VStack() {
                    HStack() {
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .medium))
                                .scaledToFill()
                                .frame(width: 45 ,height: 45)
                                .background(Color ("background1"))
                                .clipShape(Circle())
                                .foregroundColor(Color ("button1"))
    //                            .overlay(Circle().stroke(gradientBlueAccentSea, lineWidth: 1))
                        }
                        .shadow(radius: 4, y: 2)
                        .padding(.trailing, 15)
                        .padding(.bottom, 15)
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }
}

//struct UserGroupDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        UserGroupDetail()
//    }
//}
