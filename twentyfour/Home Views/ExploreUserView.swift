//
//  AppUserDetail.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ExploreUserView: View {
    var appUser: AppUser
    var items: [AppUser]
            
            @State var showingMenu = false
            @State var activateGroup = false
            @State var selectedScreen = 0
            @State var showButtons = false
            
            @State var requets: [AppUser] = []
            
            func addAppUserToRequests(appUser: AppUser) {
                requets.append(appUser)
            }
        
        func setSelectedScreen(screenIndex: Int){
            self.selectedScreen = screenIndex
        }
        
        func makeGradient(colors: [Color]) -> some View {
            LinearGradient(
                gradient: .init(colors: colors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
            
            var gradient: LinearGradient {
                LinearGradient(
                    gradient: Gradient(
                        colors:
                        [
                            Color ("AmaGreen"),
                            Color ("AmaBlue"),

    //                                                .pink,
    //                        Color ("LightGray"),
    //                        Color ("LightGray"),
    //                        .pink,
    //                        .pink
    //                        Color("Cherry"),
    //
    //                        Color ("Sea"),
    //                        Color ("AmaBlue"),
                            
    //                        Color ("CandyGreen"),
    //                        Color ("Darknight"),
    //                        Color ("Violet"),
    //                        .pink,
        //                    Color ("Darknight"),
        //                    .purple,
        //                    Color ("DarkGreen"),
        //                    Color ("Sea"),
                            
    //                        Color ("Cherry")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            }
                
                var gradientGray: LinearGradient {
                    LinearGradient(
                        gradient: Gradient(
                            colors:
                            [
            //                    Color ("AmaGreen"),
            //                    Color ("AmaBlue"),
                                Color ("SuperLightGray"),
                                Color ("SuperLightGray"),
            //                    Color ("CandyGreen"),
            //                    Color ("Darknight"),
            //                    Color ("Violet"),
            //                    Color ("Darknight"),
            //                    .purple,
            //                    Color ("DarkGreen"),
            //                    Color ("Sea"),
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                }
    
    private let imageHeight: CGFloat = 140
    private let collapsedImageHeight: CGFloat = 110
    
    @ObservedObject private var articleContent: ViewFrame = ViewFrame()
    @State private var titleRect: CGRect = .zero
    @State private var headerImageRect: CGRect = .zero
    
    func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight
        
        // if our offset is roughly less than -225 (the amount scrolled / amount off screen)
        if offset < -sizeOffScreen {
            // Since we want 75 px fixed on the screen we get our offset of -225 or anything less than. Take the abs value of
            let imageOffset = abs(min(-sizeOffScreen, offset))
            
            // Now we can the amount of offset above our size off screen. So if we've scrolled -250px our size offscreen is -225px we offset our image by an additional 25 px to put it back at the amount needed to remain offscreen/amount on screen.
            return imageOffset - sizeOffScreen
        }
        
        // Image was pulled down
        if offset > 0 {
            return -offset
            
        }
        
        return 0
    }
    
    func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height
        
        if offset > 0 {
            return imageHeight + offset
        }
        
        return imageHeight
    }
    
    // at 0 offset our blur will be 0
    // at 300 offset our blur will be 6
    func getBlurRadiusForImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).maxY
        
        let height = geometry.size.height
        let blur = (height - max(offset, 0)) / height // (values will range from 0 - 1)
        
        return blur * 6 // Values will range from 0 - 6
    }
    
    // 1
    private func getHeaderTitleOffset() -> CGFloat {
        let currentYPos = titleRect.midY
        
        // (x - min) / (max - min) -> Normalize our values between 0 and 1
        
        // If our Title has surpassed the bottom of our image at the top
        // Current Y POS will start at 75 in the beggining. We essentially only want to offset our 'Title' about 30px.
        if currentYPos < headerImageRect.maxY {
            let minYValue: CGFloat = 50.0 // What we consider our min for our scroll offset
            let maxYValue: CGFloat = collapsedImageHeight // What we start at for our scroll offset (75)
            let currentYValue = currentYPos

            let percentage = max(-1, (currentYValue - maxYValue) / (maxYValue - minYValue)) // Normalize our values from 75 - 50 to be between 0 to -1, If scrolled past that, just default to -1
            let finalOffset: CGFloat = -30.0 // We want our final offset to be -30 from the bottom of the image header view
            // We will start at 20 pixels from the bottom (under our sticky header)
            // At the beginning, our percentage will be 0, with this resulting in 20 - (x * -30)
            // as x increases, our offset will go from 20 to 0 to -30, thus translating our title from 20px to -30px.
            
            return 20 - (percentage * finalOffset)
        }
        
        return .infinity
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Finde Personen und Gruppen, die in 24 Stunden das gleiche suchen wie du!")
                    .font(.avenirNextRegular(size: 18))
                    .fontWeight(.bold)
                    .padding([.leading, .trailing], 20)
                        .padding(.top, 20)
                    .foreground(Color ("DarkGray"))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(4)
                                
                                HStack() {
                                    Spacer()
                    //                Button Person
                                        Button(action: {
                                            self.setSelectedScreen(screenIndex: 0)
                                        }) {
                                            Circle()
                                                .fill(selectedScreen == 0 ? gradient : gradientGray)
                    //                        .fill(Color ("BrightGray"))
                                            .overlay(
                                                Image(systemName: "person.fill")
                            //                        Image(systemName: selectedScreen == 0 ? "person.fill" : "person")
                                                    .font(.avenirNextRegular(size: selectedScreen == 0 ? 22 : 16))
                            //                            .font(.avenirNextRegular(size: 24))
                                                    .animation(.easeInOut(duration: 0.5))
                                                .fixedSize()
                                                .frame(height: 10.0)
                                                .padding(.horizontal)
                                                .padding(.vertical, 10.0)
                                                    .foreground(Color(selectedScreen == 0 ? "Midnight" : "DarkGray"))
                    //                                .foregroundColor(.white)
                                            )
                                            .frame(width: 48, height: 48)
                                            
                                        }
                                    
                        //                Button Group
                                        Button(action: {
                                            self.setSelectedScreen(screenIndex: 1)
                                        }) {
                                            Circle()
                                                .fill(selectedScreen == 1 ? gradient : gradientGray)
                                                .overlay(
                                                    Image(systemName: "person.3.fill")
                                                        .font(.avenirNextRegular(size: selectedScreen == 1 ? 22 : 16))
                                                        .animation(.easeInOut(duration: 0.5))
                                                        .fixedSize()
                                                        .frame(height: 10.0)
                                                        .padding(.horizontal)
                                                        .padding(.vertical, 10.0)
                                                        .foreground(Color(selectedScreen == 1 ? "Midnight" : "DarkGray"))
                                            )
                                            .frame(width: 48, height: 48)
                                            
                                        }
                                    Spacer()
                                }
                                .padding(.bottom, 20)
                                
                                
                                // Person
                                if selectedScreen == 0 {
                                    HomeAppUserRow(items: appUserData)
                                    .frame(height: 460)
                                }
                                if selectedScreen == 1 {
                                    
                                    HomeGroupRow(items: appUserData)
                                    .frame(height: 300)
                                }
                                
                                ActivityDescriptionView()
                                    .background(Color ("LightGray"))
                    
                    
//                    x
                    
//                    HStack {
////                        Image("basti")
//                        appUser.image
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 55, height: 55)
//                            .clipShape(Circle())
//                            .shadow(radius: 4)
//
//                        VStack(alignment: .leading) {
//                            Text("Article Written By")
//                                .font(.avenirNext(size: 12))
//                                .foregroundColor(.gray)
//                            Text(appUser.username)
//                                .font(.avenirNext(size: 17))
//                        }
//                    }
                    
//                    Text("02 January 2019 • 5 min read")
//                        .font(.avenirNextRegular(size: 12))
//                        .foregroundColor(.gray)
                    
                    Text("How to build a parallax scroll view")
                        .font(.avenirNext(size: 28))
                        .background(GeometryGetter(rect: self.$titleRect)) // 2
                    
//                    Text(loremIpsum)
//                        .lineLimit(nil)
//                        .font(.avenirNextRegular(size: 17))
                }
//                .padding(.horizontal)
                .padding(.top, 16.0)
            }
            .offset(y: imageHeight + 16)
            .background(GeometryGetter(rect: $articleContent.frame))
            
            GeometryReader { geometry in
                // 3
                ZStack(alignment: .bottom) {
                    Image("pic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: self.getHeightForHeaderImage(geometry))
                        .blur(radius: self.getBlurRadiusForImage(geometry))
                        .clipped()
                        .background(GeometryGetter(rect: self.$headerImageRect))

                    // 4
                    Text("How to build a parallax scroll view")
                        .font(.avenirNext(size: 17))
                        .foregroundColor(.white)
                        .offset(x: 0, y: self.getHeaderTitleOffset())
                }
                .clipped()
                .offset(x: 0, y: self.getOffsetForHeaderImage(geometry))
            }.frame(height: imageHeight)
            .offset(x: 0, y: -(articleContent.startingRect?.maxY ?? UIScreen.main.bounds.height))
        }.edgesIgnoringSafeArea(.all)
//        .navigationBarTitle("\(appUser.username)", displayMode: .inline)
            .navigationBarTitle("", displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
    }
}


struct ExploreUserView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreUserView(appUser: appUserData[0], items: appUserData)
    }
}
