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
    
    @State var showingProfile = false
    @State var showButtons = false
    @State var pageIndex_old = 0
    @State var pageIndex = 0
    @State var lockScreen: Bool = false
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.black.opacity(0.2), Color.black.opacity(0.0)]),
            startPoint: .bottom,
            endPoint: .top)
    }
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
        
        UITableView.appearance().separatorInset = .zero
    }
    
    func makeGradientTopToBottom(colors: [Color]) -> some View {
        LinearGradient(
            gradient: .init(colors: colors),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
             
        
//        NavigationView {
        VStack() {
            if !userData.isLogged {
                ZStack(){
                    SignInView()
                }
            } else {
                
            ZStack() {
                
                
                // USER IS ALREADY LOGGED IN
                // VERIFIED BY FIREBASE USER STORE + LOCAL USER STORE (COMPLETE PROFILE ENTITY OR JUST DOCUMENT ID OF USER)
                
                VStack(alignment: .leading) {
                    // ExploreView
                    if pageIndex == 0 {
                        ExploreView(
                            items: appUserData,
                            pageIndex_old: $pageIndex_old,
//                            groupList: $groupList,
                            pageIndex: $pageIndex
                        )
                    }
                }
                    
                VStack() {
                    Spacer()
                    ButtonBarView(pageIndex: $pageIndex)
                        .background(Color .white)
                        .offset(y: userData.buttonBarOffset)
                }
                .animation(.spring())
                    
                VStack() {

                    SearchView()
                        .background(Color .white)
                        .offset(y: userData.searchViewOffsetY)
                }
                .animation(.spring())
                
            }
            }
        }
//        .navigationBarHidden(true)
//        .navigationBarTitle("", displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
    }
    
}

struct CurrentUser: View {
    var currentUser: Profile
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



