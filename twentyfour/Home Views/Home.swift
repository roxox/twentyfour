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
    
    var body: some View {
        
        NavigationView {
            ZStack() {
                VStack() {
                    VStack(alignment: .leading) {
                        ScrollView(.vertical, showsIndicators: false) {

                            // ExploreView
                            if tabBarIndex == 0 {
                                ExploreView(items: appUserData, groupList: $groupList)
                                .padding(.top, 80)
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

//                    Custom TapBar
                    ButtonBarView(tabBarIndex: $tabBarIndex)
                    .padding(.bottom, 30)
                }
                
                VStack() {
                    Spacer()
                    // Create Group Button
                    if groupList.count != 0 {
                        HStack(){
                            VStack(){
                                Button(action: {
                                }) {
                                    Text("Gruppe mit \(groupList.count) Teilnehmern erstellen")
                                        .font(.avenirNextRegular(size: 14))
    //                                    .bold()
                                        .fontWeight(.semibold)
                                        .fixedSize()
                                        .frame(height: 15)
                                        .padding()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(Color .white)
                                        .foregroundColor(Color ("DarkGray"))
                                }
                                    
                                .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color ("DarkGray"), lineWidth: 0.1)
                                )
//                                .shadow(radius: 3, x: 0, y: 2)
                                .padding(.top, 10)

                                Button(action: {
                                    self.groupList.removeAll()
                                }) {
                                    Text("Abbrechen")
                                        .font(.avenirNextRegular(size: 14))
    //                                    .bold()
                                        .fontWeight(.semibold)
                                        .fixedSize()
                                        .frame(height: 15)
                                        .padding()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(Color .white)
                                        .foregroundColor(Color ("Peach"))
                                }
                                    
                                .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color ("DarkGray"), lineWidth: 0.1)
                                )
//                                .shadow(radius: 3, x: 0, y: 2)
                                    .padding(.top, 10)
                            }
                        }
                        .padding(.bottom)
                        .padding([.leading, .trailing], 20)
                        .offset(x: 0, y: -55)
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
