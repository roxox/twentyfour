//
//  SignInView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    @State var isFocused = false
    @State var isLoading = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong."
    @State var isSuccessful = false
    @EnvironmentObject var user: UserData
    
    func login() {
        hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.isLoading = false
            
            if error != nil {
                self.alertMessage = error?.localizedDescription ?? ""
                self.showAlert = true
            } else {
                self.isSuccessful = true
                self.user.isLogged = true
                UserDefaults.standard.set(true, forKey: "isLogged")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.email = ""
                    self.password = ""
                    self.isSuccessful = false
                    self.user.showLogin = false
                }
            }
        }
    }
    
    var body: some View {
        
        ZStack() {
                    Color.black.edgesIgnoringSafeArea(.all)
                    
                    ZStack(alignment: .top) {
                        
                        Color("background2")
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .edgesIgnoringSafeArea(.bottom)
                        
        //                CoverView()
                        
                        VStack {
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                    .frame(width: 44, height: 44)
                                    .background(Color("background1"))
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                    .padding(.leading)
                                
                                TextField("Your Email".uppercased(), text: $email)
                                    .keyboardType(.emailAddress)
                                    .font(.subheadline)
                //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading)
                                    .frame(height: 44)
                                    .onTapGesture {
                                        self.isFocused = true
                                }
                            }
                            
                            Divider().padding(.leading, 80)
                            
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                                    .frame(width: 44, height: 44)
                                    .background(Color("background1"))
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                                    .padding(.leading)
                                
                                SecureField("Password".uppercased(), text: $password)
                                    .keyboardType(.default)
                                    .font(.subheadline)
                                    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading)
                                    .frame(height: 44)
                                    .onTapGesture {
                                        self.isFocused = true
                                }
                            }
                        }
                        .frame(height: 136)
                        .frame(maxWidth: 712)
                        .background(BlurView(style: .systemMaterial))
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                        .padding(.horizontal)
                        .offset(y: 460)
                        
                        HStack {
                            Text("Forgot password?")
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Button(action: {
                                self.login()
                            }) {
                                Text("Log in").foregroundColor(.black)
                            }
                            .padding(12)
                            .padding(.horizontal, 30)
                            .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .padding()
                        
                    }
                    .offset(y: isFocused ? -300 : 0)
                    .animation(isFocused ? .easeInOut : nil)
                    .onTapGesture {
                        self.isFocused = false
                        hideKeyboard()
                    }
                    
                    if isLoading {
                        LoadingView()
                    }
                    
                    if isSuccessful {
                        SuccessView()
                    }
                }
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
