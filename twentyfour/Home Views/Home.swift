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
    @State var tabBarIndex = 0
    @State var groupList: [AppUser] = []
    
    func setSelectedScreen(screenIndex: Int){
        self.selectedScreen = screenIndex
    }
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        
        UITableView.appearance().separatorInset = .zero
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    var gradientMenu: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .top)
    }

    var gradientColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
//                    Color ("Sea"),
//                    Color ("AmaBlue"),
                    .pink,
                    .pink,
                    Color ("Peach")
//                    .pink
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
    
    var gradientWhite: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors:
                [
                    .white,
                    .white,
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var body: some View {
        
        NavigationView {
            ZStack() {
                VStack() {
                    VStack(alignment: .leading) {
                        ScrollView(.vertical, showsIndicators: false) {

                            // ExploreView
                            if tabBarIndex == 0 {
                                ExploreView(items: appUserData, groupList: $groupList)
                                .padding(.top, 60)
                            }

                        }
                    }
                }
                
                VStack() {

//                    SearchBar

                    if tabBarIndex == 0 {
                                                
                        SearchButtonView()
                        .offset(x: 0, y: -55)
    //                            .padding(.top, 40)
                    }
                    

                    Spacer()
                    if (tabBarIndex == 0 && groupList.count == 0) {
                
                        ZStack() {
                            Rectangle().fill(Color ("SuperLightGray"))
                                .frame(width: 48, height: 38)
                                .padding(.bottom, 10)
                                .padding(.horizontal, 20)
                        HStack() {
                                Button(action: {
                                    self.setSelectedScreen(screenIndex: 0)
                                }) {
                                    RoundedRectangle(cornerRadius: 19)
                                        .fill(selectedScreen == 0 ? gradientColor : gradientGray)
                                        .overlay(
                                            HStack() {
                                                Image(systemName: "person.fill")
                                                    .padding(.vertical, 10.0)
                                                }
                                                .font(.avenirNextRegular(size: 16))
                                                .foreground(selectedScreen == 0 ? .white : Color("DarkGray"))
                                    )
                                    .frame(width: 48, height: 38)
                                }
            
                //                Button Group
                                Button(action: {
                                    self.setSelectedScreen(screenIndex: 1)
                                }) {
                                    RoundedRectangle(cornerRadius: 19)
                                        .fill(selectedScreen == 1 ? gradientColor : gradientGray)
                                        .overlay(
                                            HStack() {
                                                Image(systemName: "person.3.fill")
                                                    .padding(.vertical, 10.0)
                                                }
                                                .font(.avenirNextRegular(size: 16))
                                                .foreground(selectedScreen == 1 ? .white : Color("DarkGray"))
                                    )
                                        .frame(width: 48, height: 38)
                                }
            
//                            Spacer()
                        }
                        .padding(.bottom, 10)
//                        .padding(.horizontal, 20)
                        }
                    }

//                    Custom TapBar
                    if groupList.count == 0 {
                        
                        ButtonBarView(tabBarIndex: $tabBarIndex)
                            .padding(.bottom, 30)
                    }
                }
                
                VStack() {
                    Spacer()
                    // Create Group Button
                    if groupList.count != 0 {
                        ZStack(){

                            Rectangle().fill(gradientMenu)
                                .frame(height: 180)
////                                .overlay(
////                                    VisualEffectView(effect: UIBlurEffect(style: .dark))
////                                    .edgesIgnoringSafeArea(.all)
////                            )
//                                .shadow(radius: 3, x: 0, y: 0)
                            
                            HStack(){
                                VStack(){
                                    Button(action: {
                                    }) {
                                        Text("Gruppe mit \(groupList.count) Teilnehmern erstellen")
                                            .font(.avenirNextRegular(size: 15))
                                            .fontWeight(.semibold)
//                                            .fixedSize()
//                                            .frame(height: 15)
                                            .padding()
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .background(Color .white)
                                            .foregroundColor(Color ("DarkGray"))
                                            .cornerRadius(8)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color ("DarkGray"), lineWidth: 0.1)
                                            )
                                    }
                                    
                                    Spacer()
                                        .frame(height: 10)
                                    
                                    Button(action: {
                                        self.groupList.removeAll()
                                    }) {
                                        Text("Abbrechen")
                                            .font(.avenirNextRegular(size: 15))
                                            .fontWeight(.semibold)
//                                            .fixedSize()
//                                            .frame(height: 15)
                                            .padding()
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .background(Color .white)
                                            .foregroundColor(Color .red)
                                            .cornerRadius(8)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color ("DarkGray"), lineWidth: 0.1)
                                            )
                                    }
                                }
//                                .shadow(radius: 3, x: 0, y: 2)
                            }
                            .padding(.bottom)
                            .padding([.leading, .trailing], 20)
                            .offset(x: 0, y: -26)
                        }
//                    .padding(.vertical, 55)
                    }
//                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
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

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


