//
//  ExploreSearchView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 23.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Firebase

var gradientCherryPink: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
            [
                Color ("Cherry"),
                .pink,
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

struct ExploreSearchButtonView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var showButtons = false
    @State var selectedScreen = 0
    
    
    
    func logout() {
        hideKeyboard()
//        self.isLoading = true
        
        try! Auth.auth().signOut()
        userData.isLogged = false
        
        
        
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            self.isLoading = false
//
//            if error != nil {
//                self.alertMessage = error?.localizedDescription ?? ""
//                self.showAlert = true
//            } else {
//                self.isSuccessful = true
//                self.user.isLogged = true
//                UserDefaults.standard.set(true, forKey: "isLogged")
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.email = ""
//                    self.password = ""
//                    self.isSuccessful = false
//                    self.user.showLogin = false
//                }
//            }
//        }
    }
    
    func openSearchView() {
        userData.searchViewOffsetY = CGFloat (0)
    }
    
    var body: some View {
        
            ZStack(alignment: .top) {

                Rectangle().fill(Color .clear)
                    .frame(height: 120)
                
                HStack(alignment: .top){
                    Spacer()
                    
                    // SearchButton
                    Button(action: {
                        withAnimation(.linear(duration: 0.2)) {
                            self.openSearchView()
                        }
                    }) {
                        HStack() {
                            
                            
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(.black)
                                .fixedSize()
                                .frame(width: 45, height: 45)
                                .background(gradientGray)
                                .clipShape(Circle())
                            
//                            Text("Suche ändern oder beenden")
//    //                            .font(.avenirNextRegular(size: 20))
//    //                            .fontWeight(.semibold)
//                                    .font(.avenirNextRegular(size: 14))
//                                    .fontWeight(.light)
//                                    .foregroundColor(.black)
//                                .fixedSize()
//                                .truncationMode(.head)
                        }
                        
                    }
//                    .fixedSize()
//                    .padding(.horizontal, 20)
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    
//                    Spacer()

//                    HStack() {
//
//                        Spacer()
//                        Button(action: {
//    //                        self.addOrRemoveOperator(operatorType: .minus)
//                        }) {
//                            VStack() {
//                            Image(systemName: "person")
//                                .font(.avenirNextRegular(size: 16))
//                                .frame(width: 46, height:30)
//                                .background(gradientCherryPink)
//                                .foregroundColor(Color ("LightGray"))
//    //                            .background(userData.selectedOperations.contains(.minus) ? gradientCherryAndPink : gradientGray)
//    //                            .foregroundColor(userData.selectedOperations.contains(.minus) ? Color .white : Color .gray)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//
//                                Text("Benutzer")
//                                    .font(.avenirNextRegular(size: 10))
//                                    .fontWeight(.semibold)
//                                    .fixedSize(horizontal: false, vertical: true)
//                                    .lineLimit(1)
//                                    .foreground(gradientCherryPink)
//                                    .offset(y: -5)
//
//                            }
//                        .buttonStyle(BorderlessButtonStyle())
//                        }
//
//                        Button(action: {
//                            self.logout()
//    //                        self.addOrRemoveOperator(operatorType: .minus)
//                        }) {
//                            VStack() {
//                            Image(systemName: "person.3")
//                                .font(.avenirNextRegular(size: 16))
//                                .frame(width: 52, height:30)
//                                .background(gradientGray)
//                                .foregroundColor(Color ("DarkGray"))
//    //                            .background(userData.selectedOperations.contains(.minus) ? gradientCherryAndPink : gradientGray)
//    //                            .foregroundColor(userData.selectedOperations.contains(.minus) ? Color .white : Color .gray)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//
//                                Text("Gruppen")
//                                    .font(.avenirNextRegular(size: 10))
//                                    .fontWeight(.semibold)
//                                    .fixedSize(horizontal: false, vertical: true)
//                                    .lineLimit(1)
//                                    .foreground(Color ("DarkGray"))
//                                    .offset(y: -5)
//                        }
//                        .buttonStyle(BorderlessButtonStyle())
//                        }
//
//
//                    }
            
                }
                .padding([.leading, .trailing], 20)
//                .padding([.top], 60)
        }
        .navigationBarHidden(true)
    }
}

struct ExploreSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreSearchButtonView()
    }
}
