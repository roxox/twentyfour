//
//  SearchView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 11.05.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
    @State var isFocused = false
    @State var keyboardHeight = CGFloat (0)
    @State var showKeyboard = false
    @State var remainingTime: Int = 0
    
    @State var tmpLocationString: String = ""
    @State var tmpMaxDistance: Double = 0
    @State var tmpEventTypes: [EventType] = []
    
    func closeSearchView() {
        hideKeyboard()
        userData.searchViewOffsetY = UIScreen.main.bounds.height
    }
    
    func copyValuesToTmpValues() {
        self.tmpLocationString = self.searchDataContainer.locationString
        self.tmpMaxDistance = self.searchDataContainer.maxDistance
        self.tmpEventTypes = self.searchDataContainer.eventTypes
    }
    
    func isModified() -> Bool {
        if self.tmpLocationString != searchDataContainer.locationString {
            return true
        }
        
        if self.tmpMaxDistance != searchDataContainer.maxDistance {
            return true
        }
        
        
        if self.tmpEventTypes != searchDataContainer.eventTypes {
            return true
        }
        
        return false
    }
    
    func saveValues() {
        searchDataContainer.copyTmpValuesToValues(tmpLocationString: tmpLocationString, tmpMaxDistance: tmpMaxDistance, tmpEventTypes: tmpEventTypes)
        self.searchDataContainer.createOrUpdate()
        
        self.closeSearchView()
        
        self.searchDataContainer.createOrUpdate()
        self.closeSearchView()
    }
    
    func getLabel() -> String {
        if self.remainingTime > 0 {
            return "Speichern"
        }
        return "Erstellen"
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
            ScrollView() {
                
                    HStack() {
                        Spacer()
                            Text("Standort")
                                .font(.avenirNextRegular(size: 20))
                                .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                
                    HStack() {
                            Image("locationBlack")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 20, height: 20)
                                .scaledToFill()
                        
                        VStack() {
                            TextField("Location", text: self.$tmpLocationString)
                                .font(.avenirNextRegular(size: 22))
                                .offset(y: 5)
                                .onTapGesture {
                                    self.isFocused = true
                                }
                            Divider()
                        }
                        .padding(.trailing, 40)
                            
                            Spacer()
                        }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                HStack() {
                    HStack() {
                        
                        Image(systemName: "location.fill")
                            .font(.system(size: 14, weight: .medium))
                            .fixedSize()
                            .frame(width: 20, height: 20)
                            .foreground(gradientSeaAndBlue)
                        
                        Text("In der Umgebung")
                            .font(.avenirNextRegular(size: 14))
                    }
                    .frame(height: 30)
                    .padding(.horizontal, 7)
                    .background(gradientGray)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Spacer()
                }
                    .padding(.horizontal, 45)
                    .padding(.top, 5)
                            
                    HStack() {
                        
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .fixedSize()
                            .frame(width: 20, height: 20)
                        
                        Text("max. Enterfernung: ")
                            .font(.avenirNextRegular(size: 22))
    //                        .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("\(Int(self.tmpMaxDistance)) km")
                        .font(.avenirNextRegular(size: 20))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 25)
                                        
                    HStack() {
                        Slider(value: self.$tmpMaxDistance, in: 2...150, step: 1)
                    }
                    .padding(.horizontal, 50)
                    .padding(.bottom, 20)
                    
                    Divider()
                
                ButtonAreaView(searchDataContainer: self.searchDataContainer, tmpEventTypes: self.$tmpEventTypes)
                
                if self.searchDataContainer.targetDate > self.searchDataContainer.currentTime {
                RequestView(searchDataContainer: self.searchDataContainer)
                .padding(.bottom, 80)
                }
                
            }
            .background(Color ("background1"))
            .foregroundColor(Color ("button1"))
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 25)
                VStack() {
//                    Spacer()
                    
                    VStack() {
                        
                        HStack(){
//                            Spacer()
                            
//                            Spacer()
                            // CANCEL BUTTON
                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    self.closeSearchView()
                                }
                            }) {
                                HStack(){
                                    Image(systemName: "xmark")
                                        .font(.system(size: 20, weight: .medium))
                                        .frame(width: 36, height: 36)
//                                        .padding(.leading, 10)
                                    Text("Verwerfen")
                                        .font(.avenirNextRegular(size: 16))
                                        .fontWeight(.semibold)
//                                        .padding(.trailing, 20)
                                }
                            }
                                .frame(height: 36)
                                .foregroundColor(Color ("button1"))
//                                .background(gradientSeaAndBlue)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            Spacer()
                            
                            
                            // SAVE BUTTON
                            if self.isModified() && self.tmpEventTypes.count != 0 && self.tmpLocationString != "" {
                                Button(action: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        self.saveValues()
                                    }
                                }) {
                                    HStack(){
                                        Text(self.getLabel())
                                            .font(.avenirNextRegular(size: 16))
                                            .fontWeight(.semibold)
//                                            .padding(.trailing, 20)
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 20, weight: .medium))
                                            .frame(width: 36, height: 36)
    //                                        .padding(.leading, 10)
                                    }
                                }
                                .frame(height: 36)
                                .foregroundColor(Color ("button1"))
//                                .background(gradientSeaAndBlue)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            
//                            Spacer()
                        }
                        .padding(.horizontal, 20)
//                        .padding(.bottom, 15)
                        .background(Color ("background1"))
//                        .animation(self.isFocused ? .easeInOut : nil)

                        .onAppear() {
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti)  in
                            
                                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                                let height = value.height
                                
                                self.keyboardHeight = height
                                self.showKeyboard = true
                            }
                            
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti)  in
                                self.keyboardHeight = 0
                                self.showKeyboard = false
                            }
                        }
                    }
//                    .offset(y: 15)
                    Spacer()
//                    Rectangle().fill(Color .clear)
//                        .background(BlurView(style: .systemMaterial))
//                        .frame(height: max(0, geometry.safeAreaInsets.bottom - 20))
                }
//                .edgesIgnoringSafeArea(.bottom)
                
                if self.showKeyboard == true {
                    VStack(){
                        Spacer()
                        HStack(){
                            Spacer()
                            // Hide Keyboard
                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    hideKeyboard()
                                }
                            }) {
                                HStack(){
                                Image(systemName: "keyboard.chevron.compact.down")
                                    .font(.system(size: 20, weight: .medium))
                                    .frame(width: 36, height: 36)
                                    .padding(.trailing, 10)
                                }
                            }
                            .foregroundColor(.black)

                            .onAppear() {
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti)  in
                                
                                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                                    let height = value.height
                                    
                                    self.keyboardHeight = height
                                    self.showKeyboard = true
                                }
                                
                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti)  in
                                    self.keyboardHeight = 0
                                    self.showKeyboard = false
                                }
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding(self.showKeyboard ? 15 : 15)
                        .background(BlurView(style: .systemMaterial))
                    }
                    .offset(y: -self.keyboardHeight + 35)
                    .animation(.spring())
//                    .edgesIgnoringSafeArea(.bottom)
                }
            }
            .onTapGesture {
                hideKeyboard()
                self.isFocused = false
            }
            .onReceive(self.searchDataContainer.remainingTimeWillChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    self.remainingTime = newValue
                }
            }
            .onReceive(self.searchDataContainer.eventTypesWillChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    self.tmpEventTypes = newValue
                }
            }
            .onReceive(self.searchDataContainer.locationStringWillChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    self.tmpLocationString = newValue
                }
            }
            .onReceive(self.searchDataContainer.maxDistanceWillChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    self.tmpMaxDistance = newValue
                }
            }
            .onAppear() {
                self.copyValuesToTmpValues()
            }
            .animation(.spring())
        }
    }
}

struct ButtonAreaView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
    
//    @Binding var tmpLocationString: String
//    @Binding var tmpMaxDistance: Double
    @Binding var tmpEventTypes: [EventType]

    func addOrRemoveEventTyoe(eventType: EventType) {
        if !self.tmpEventTypes.contains(eventType){
            self.addEventType(eventType: eventType)
        } else {
            self.removeEventType(eventType: eventType)
        }
    }
    
    func addEventType(eventType: EventType) {
        if !self.tmpEventTypes.contains(eventType){
            self.tmpEventTypes.append(eventType)
        }
    }
    
    func removeEventType(eventType: EventType) {
        let removeIndex: Int = self.tmpEventTypes.firstIndex(of: eventType)!
        if self.tmpEventTypes.contains(eventType){
            self.tmpEventTypes.remove(at: removeIndex)
        }
    }
    
    func containsType(eventType: EventType) -> Bool {
        if self.tmpEventTypes.contains(eventType){
            return true
        }
        return false
    }
    
    var body: some View {
        VStack(){
            
            // HEADLINE
            HStack() {
                Spacer()
                    VStack(){
                        Text("Aktivität")
                            .font(.avenirNextRegular(size: 20))
                            .fontWeight(.semibold)
                        if self.tmpEventTypes.count == 0 {
                            Text("Wähle mindestens eine Aktivität")
                                .font(.avenirNextRegular(size: 10))
                                .fontWeight(.semibold)
                                .foreground(gradientCherryPink)
                        }
                    }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // BUTTON FOOD
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.addOrRemoveEventTyoe(eventType: .food)
                }
            }) {
                HStack() {
                    VStack(alignment: .leading){
                        Text("Essen und Trinken")
                            .font(.avenirNextRegular(size: 22))
                        Text("Hier gibt es auch etwas Text")
                        .font(.avenirNextRegular(size: 14))
                        .fontWeight(.light)
                    }
                    Spacer()
                    EventTypeImage(imageString: "essen")
                        .saturation(self.tmpEventTypes.contains(.food) ? 1.0 : 0.0)
                        .padding(.leading, 5)
                
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
                .frame(width: UIScreen.main.bounds.width)
            }
            
            // BUTTON ACTIVITY
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.addOrRemoveEventTyoe(eventType: .activity)
                }
            }) {
                HStack() {
                    VStack(alignment: .leading){
                        Text("Freizeit")
                            .font(.avenirNextRegular(size: 22))
                        Text("Ganz viel neuer Text könnte hier drinstehen, um die EventTypes zu erläutern.")
                        .font(.avenirNextRegular(size: 14))
                        .fontWeight(.light)
                    }
                    Spacer()
                    EventTypeImage(imageString: "freizeit2")
                        .saturation(self.tmpEventTypes.contains(.activity) ? 1.0 : 0.0)
                        .padding(.leading, 5)
                
                }
                .padding(20)
                .frame(width: UIScreen.main.bounds.width)
            }
            
            // BUTTON SPORT
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.addOrRemoveEventTyoe(eventType: .sport)
                }
            }) {
                HStack() {
                    VStack(alignment: .leading){
                        Text("Sport")
                            .font(.avenirNextRegular(size: 22))
                        Text("Und noch einmal: Ganz viel neuer Text könnte hier drinstehen, um die EventTypes zu erläutern.")
                        .font(.avenirNextRegular(size: 14))
                        .fontWeight(.light)
                    }
                    Spacer()
                    EventTypeImage(imageString: "sport")
                        .saturation(self.tmpEventTypes.contains(.sport) ? 1.0 : 0.0)
                        .padding(.leading, 5)
                
                }
                .padding(20)
                .frame(width: UIScreen.main.bounds.width)
            }
            
        }
    }
    
    
}

struct RequestView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchDataContainer: SearchDataContainer
    
//    @Binding var tmpEventTypes: [EventType]
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var remainingTime: Int = 0

    func secondsToHours (seconds : Int) -> (Int) {
        return (Int(seconds) / 3600)
    }

    func secondsToMinutes (seconds : Int) -> (Int) {
        return ((Int(seconds) % 3600) / 60)
    }

    func secondsToSeconds (seconds : Int) -> (Int) {
        return ((Int(seconds) % 3600) % 60)
    }
    
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: searchDataContainer.created)
        return dateString
    }
    
    var body: some View {
        VStack() {
            
            Divider()
            // HEADLINE
            HStack() {
                Spacer()
                    VStack(){
                        Text("Anfrage / Suche")
                            .font(.avenirNextRegular(size: 20))
                            .fontWeight(.semibold)
                    }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            
            
            HStack() {
                Text("Erstellt am: \(self.getFormattedDate())")
                        .font(.avenirNextRegular(size: 14))
                        .fontWeight(.light)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 20)
            
            
            HStack() {
                if secondsToHours(seconds: remainingTime) != 0 {
                    Text("Aktiv für die nächsten \(secondsToHours(seconds: remainingTime)):\(secondsToMinutes(seconds: remainingTime)):\(secondsToSeconds(seconds: remainingTime)) Stunden")
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.light)
                } else if secondsToHours(seconds: remainingTime) == 0 && secondsToMinutes(seconds: remainingTime) != 0{
                    Text("Aktiv für die nächsten \(secondsToMinutes(seconds: remainingTime)):\(secondsToSeconds(seconds: remainingTime)) Minuten")
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.light)
                } else {
                    Text("Aktiv für die nächsten \(secondsToSeconds(seconds: remainingTime)) Sekunden")
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.light)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.bottom, 20)
            

            // Verlängern
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.searchDataContainer.extendTimer()
                }
            }) {
                HStack() {
                    Image(systemName: "repeat")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.black)
                        .fixedSize()
                        .frame(width: 45, height: 45)
                    Text("Verlängern")
                        .padding(.trailing)
                }
                .frame(height: 46)
                .foreground(gradientPinkVioletBlueAccent)
                .background(gradientGray)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            

            // Abbrechen
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.searchDataContainer.cancel()
                }
            }) {
                HStack() {
                    Image(systemName: "trash")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.black)
                        .fixedSize()
                        .frame(width: 45, height: 45)
                    Text("Abbrechen")
                        .padding(.trailing)
                }
                .frame(height: 46)
                .foreground(gradientPinkPinkAndPeach)
                .background(gradientGray)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 20)
        }
        .onReceive(self.searchDataContainer.remainingTimeWillChange) { newValue in
            withAnimation(.linear(duration: 0.2)) {
                self.remainingTime = newValue
            }
        }
        .animation(.spring())
    }
}

struct EventTypeImage: View {
    
    let imageString: String
    var body: some View {

    Image(imageString)
        .renderingMode(.original)
        .resizable()
        .scaledToFill()
        .frame(width: 70 ,height: 70)
        .clipShape(Circle())
    }
}
