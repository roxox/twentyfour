//
//  ContentView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    
    @State var showingProfile = false
    @State var showButtons = false
    @State var selectedScreen = 0
            
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("AmaGreen"),
                    Color ("AmaBlue"),
                    
//                        Color ("Sea"),
//                        Color ("AmaBlue"),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var gradientGray: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    Color ("SuperLightGray"),
                    Color ("SuperLightGray"),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    func setSelectedScreen(screenIndex: Int){
        self.selectedScreen = screenIndex
    }
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        
        UITableView.appearance().separatorInset = .zero
    }
    
    var body: some View {
        
        NavigationView {
            ZStack() {
                VStack() {
                    VStack(alignment: .leading) {
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            // ExploreView
//                            ExploreUserView(appUser: appUserData[0], items: appUserData)
                            ExploreView(items: appUserData)
                            .padding(.top, 160)
                            
                            
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(true)
                
                VStack() {
                    
//                    SearchBar
                    SearchButtonView()
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    // Create Group Button
                    HStack(){
                        Spacer()
                        if showButtons {
                            
                            Button(action: {
                            }) {
                                Text("Gruppe mit 2 Teilnehmern erstellen")
                                    .font(.avenirNextRegular(size: 14))
//                                    .bold()
                                    .fontWeight(.semibold)
                                    .fixedSize()
                                    .frame(height: 15)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                            }
                                
                            .background(makeGradientTopToBottom(colors:
                                [
                                    Color ("Peach"),
                                    .pink,
//                                    Color ("SmoothOrange"),
//                                    .orange,
                            ]))
                                .foregroundColor(.white)
                                
                            .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color ("DarkGray"), lineWidth: 0.1)
                            )
                            .shadow(radius: 3, x: 0, y: 2)
                            .padding(.top, 10)
                            .padding([.leading, .trailing], 13)
                       }
                       Spacer()
                    }
                    
                    
//                    HStack() {
//                        Spacer()
//        //                Button Person
//                            Button(action: {
//                                self.setSelectedScreen(screenIndex: 0)
//                            }) {
//                                Circle()
//                                    .fill(selectedScreen == 0 ? gradient : gradientGray)
//        //                        .fill(Color ("BrightGray"))
//                                .overlay(
//                                    Image(systemName: "person.fill")
//                //                        Image(systemName: selectedScreen == 0 ? "person.fill" : "person")
//                                        .font(.avenirNextRegular(size: selectedScreen == 0 ? 22 : 16))
//                //                            .font(.avenirNextRegular(size: 24))
//                                        .animation(.easeInOut(duration: 0.5))
//                                    .fixedSize()
//                                    .frame(height: 10.0)
//                                    .padding(.horizontal)
//                                    .padding(.vertical, 10.0)
//                                    .foreground(Color(selectedScreen == 0 ? "Midnight" : "DarkGray"))
//
//        //                                .foregroundColor(.white)
//                                )
//                                .frame(width: 48, height: 48)
//
//                            }
//
//            //                Button Group
//                            Button(action: {
//                                self.setSelectedScreen(screenIndex: 1)
//                            }) {
//                                Circle()
//                                    .fill(selectedScreen == 1 ? gradient : gradientGray)
//                                    .overlay(
//                                        Image(systemName: "person.3.fill")
//                                            .font(.avenirNextRegular(size: selectedScreen == 1 ? 22 : 16))
//                                            .animation(.easeInOut(duration: 0.5))
//                                            .fixedSize()
//                                            .frame(height: 10.0)
//                                            .padding(.horizontal)
//                                            .padding(.vertical, 10.0)
//                                            .foreground(Color(selectedScreen == 1 ? "Midnight" : "DarkGray"))
//                                )
//                                .frame(width: 48, height: 48)
//
//                            }
//                        Spacer()
//                    }
                    
//                    Spacer()
                    
//                    Custom TapBar
                    ButtonBarView()
                    .padding(.bottom, 30)
                }.edgesIgnoringSafeArea(.all)
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
    
    func makeGradient(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    func makeGradientTopToBottom(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct CurrentUser: View {
    var currentUser: AppUser
    var body: some View {
        currentUser.image
            .resizable()
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .navigationBarHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
