//
//  CreateUserDataView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 22.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct CreateUserDataView: View {
    @EnvironmentObject var session: FirebaseSession
    let user = Auth.auth().currentUser
    
    // Temporary values
    @State var tmpUsername: String = ""
    @State var tmpEmail: String = ""
    @State var tmpUserDescription: String = ""
    
    func createUserData() {
        let publicUserData = PublicUserData(uid: user!.uid, username: tmpUsername, email: tmpEmail, userDescription: tmpUserDescription)
        session.addPublicUserData(user: publicUserData) { publicUserData in
            session.publicUserData = publicUserData
        }
//        session.getPublicUserDataByUID(user!.uid)
//        }
    }
    
    func initializeTmpValues() {
        tmpEmail = user!.email ?? ""
    }
    
    func isValid() -> Bool {
        if tmpEmail != "" && tmpUsername != "" {
            return true
        }
        return false
    }
    
    var body: some View {
        VStack() {
            
            HStack(alignment: .top) {
                Image(systemName: "envelope")
                    .font(.system(size: 18, weight: .semibold))
                    .fixedSize()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.avenirNextRegular(size: 12))
                        .fontWeight(.semibold)
                    TextField("Wie lautet deine Email?", text: $tmpEmail)
                        .font(.avenirNextRegular(size: 18))
                    Divider()
                }
                .padding(.trailing, 40)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, 20)
            
            HStack(alignment: .top) {
                Image(systemName: "person")
                    .font(.system(size: 18, weight: .semibold))
                    .fixedSize()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("Username")
                        .font(.avenirNextRegular(size: 12))
                        .fontWeight(.semibold)
                    TextField("Wähle einen Usernamen!", text: $tmpUsername)
                        .font(.avenirNextRegular(size: 18))
                    Divider()
                }
                .padding(.trailing, 40)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, 20)
            
            
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.createUserData()
                }
            }) {
                HStack() {
                    Text("Profil erstellen")
                        .font(.avenirNextRegular(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .frame(height: 40)
                .background(gradientCherryPink)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .saturation(self.isValid() ? 1 : 0.2)
            .opacity(self.isValid() ? 1 : 0.2)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            
        }
        .onAppear() {
            self.initializeTmpValues()
        }
    }
}

struct CreateUserDataView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserDataView()
    }
}
