//
//  ContentView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var showingProfile = false
    @State var showButtons = false
    @State var pageIndex = 0
    @State var tabBarIndex = 0
    @State var groupList: [Profile] = []
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
    
    func didPressAddRemoveButton(profile: Profile) {
        if !groupList.contains(profile) {
            groupList.append(profile)
        } else {
            groupList.remove(at: self.groupList.firstIndex(of: profile)!)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack() {
                
                VStack(alignment: .leading) {
                    // ExploreView
                    if tabBarIndex == 0 {
                        ExploreView(
                            items: appUserData,
                            pageIndex: $pageIndex,
                            groupList: $groupList
                        )
                    }
                }
                
                VStack() {
                
                    Spacer()
                    
//                    if (tabBarIndex == 0 && groupList.count == 0) {
//                        ExplorePersonGroupToggle(pageIndex: $pageIndex)
//                        .padding(0)
//                    }

//                    Custom TapBar
                    
                        ButtonBarView(tabBarIndex: $tabBarIndex)
                            .offset(y: userData.mainMenuOffset)
//                            .padding(.bottom, 30)
//                    }
                }
                .animation(.spring())            }
        }
//        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
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
            CategoryHome()
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



