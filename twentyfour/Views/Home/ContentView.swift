//
//  ContentView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var session: FirebaseSession
    @ObservedObject var searchData = SearchData()
    
    @State var pageIndex = 0
    @State var isButtonBarHidden: Bool = false
    @State var showSearch: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorInset = .zero
    }
    
    
    
    var body: some View {
        NavigationView() {
            VStack() {
                if !session.isLogged {
                    ZStack(){
                        SignInView()
                    }
                } else {
                    
                    if !session.isPublicUserDataAvailable {
                            ZStack(){
                                CreateUserDataView()
                            }
                    } else {
                        ZStack() {
                            
                            
                            // USER IS ALREADY LOGGED IN
                            // VERIFIED BY FIREBASE USER STORE + LOCAL USER STORE (COMPLETE PROFILE ENTITY OR JUST DOCUMENT ID OF USER)
                            
                            VStack(alignment: .leading) {
                                // ExploreView
                                if pageIndex == 0 {
                                    if self.session.ownSearch != nil {
                                        ExploreView(
                                            searchData: searchData,
                                            isButtonBarHidden: self.$isButtonBarHidden,
                                            showSearch: self.$showSearch
                                        )
                                    }
                                    else {
                                        ExploreNoSearchView(
                                            searchData: searchData,
                                            showSearch: self.$showSearch
                                        )
                                    }
                                    
                                }
                                
                                if pageIndex == 1 {
                                    GroupListView(
                                    )
                                }
                                
                                if pageIndex == 3 {
                                    CurrentAppUserDetailsView(
                                        pageIndex: $pageIndex,
                                        currentUser: userData.currentUser
                                    ).environmentObject(self.userData)
                                }
                            }
                            
                            VStack() {
                                Spacer()
                                ButtonBarView(pageIndex: $pageIndex)
                                    .background(Color .clear)
                                    .offset(y: isButtonBarHidden ? CGFloat(150) : CGFloat(0))
                            }
                            .animation(.spring())
                            
                        }
                    }
                }
            }.onReceive(timer) { time in
                self.searchData.currentTime = Date()
            }
            .navigationBarHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            
            .fullScreenCover(isPresented: self.$showSearch) {
                SearchView(
                    searchData: searchData
                )
                .environmentObject(self.userData)
                .environmentObject(self.session)
            }
            
        }
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
    static var previews: some View{
        ForEach(["iPhone SE (2nd generation)", "iPhone 11 Pro Max"], id: \.self) { deviceName in
            ContentView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
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



