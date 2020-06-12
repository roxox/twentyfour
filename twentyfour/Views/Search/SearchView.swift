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
    @ObservedObject var searchData = SearchData()
    @State var isFocused = false
    @State var keyboardHeight = CGFloat (0)
    @State var showKeyboard = false
    
    
    @State var localEventType: [EventType] = []
    @State var localMaxDistance: Double = 0
    @State var localLocationString: String = ""
    
    func closeSearchView() {
        hideKeyboard()
        userData.searchViewOffsetY = UIScreen.main.bounds.height
        self.localEventType = self.searchData.selectedEventTypes
        self.localMaxDistance = self.searchData.maxDistance
        self.localLocationString = self.searchData.locationString
    }
    
    func anyChange() -> Bool {
        if localLocationString != searchData.locationString {
            return true
        }
        
        if localMaxDistance != searchData.maxDistance {
            return true
        }
        
        
        if localEventType != searchData.selectedEventTypes {
            return true
        }
        
        return false
    }
    
    func saveValues() {
        if searchData.selectedEventTypes != localEventType {
            searchData.selectedEventTypes.removeAll()
            searchData.selectedEventTypes.append(contentsOf: localEventType)
        }
        
        if searchData.maxDistance != localMaxDistance {
            searchData.maxDistance = localMaxDistance
        }
        
        if searchData.locationString != localLocationString {
            searchData.locationString = localLocationString
        }
        
        self.closeSearchView()
    }
    
    var body: some View {
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
                .padding(.top, 20)
            
                HStack() {
                        Image("locationBlack")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 20, height: 20)
                            .scaledToFill()
                    
                    VStack() {
                        TextField("Location", text: $localLocationString)
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
                    
                    Text("\(Int(localMaxDistance)) km")
                    .font(.avenirNextRegular(size: 20))
                }
                .padding(.horizontal, 20)
                .padding(.top, 25)
                                    
                HStack() {
                    Slider(value: $localMaxDistance, in: 2...150, step: 1)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 20)
                
                Divider()
            ButtonAreaView(localEventType: $localEventType)
            
            RequestView()
            .padding(.bottom, 80)
            
        }
        .foregroundColor(.black)
        .frame(minWidth: 0, maxWidth: .infinity)
            
            VStack() {
                Spacer()
                
                HStack(){
                    Spacer()

                    // SAVE BUTTON
                    if anyChange() && localEventType.count != 0 && self.localLocationString != "" {
                        Button(action: {
                            withAnimation(.linear(duration: 0.2)) {
                                self.saveValues()
                            }
                        }) {
                            HStack(){
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .medium))
                                .frame(width: 36, height: 36)
                                .padding(.leading, 10)
                                Text(self.searchData.remainingTime > 0 ? "Übernehmen" : "Erstellen")
                                    .font(.avenirNextRegular(size: 16))
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 20)
                            }
                        }
                        .frame(height: 45)
                        .foregroundColor(.white)
                        .background(gradientSeaAndBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
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
                            .padding(.leading, 10)
                        Text("Verwerfen")
                            .font(.avenirNextRegular(size: 16))
                            .fontWeight(.semibold)
                            .padding(.trailing, 20)
                        }
                    }
                    .frame(height: 45)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Spacer()
                }
                .padding(showKeyboard ? 10 : 30)
                .background(BlurView(style: .systemMaterial))
//                .offset(y: -self.keyboardHeight)

                    .offset(y: -self.keyboardHeight).animation(.spring())
                .animation(isFocused ? .easeInOut : nil)
//                .animation(nil)

                .onAppear() {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti)  in
                    
                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let height = value.height
                        
                        self.keyboardHeight = height
                        self.showKeyboard = true
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti)  in
                        
//                        self.isFocused = false
                        self.keyboardHeight = 0
                        self.showKeyboard = false
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .onTapGesture {
            hideKeyboard()
            self.isFocused = false
        }
        
        .onAppear {
            self.localEventType = self.searchData.selectedEventTypes
            self.localMaxDistance = self.searchData.maxDistance
            self.localLocationString = self.searchData.locationString
        }
        
        .onReceive(searchData.objectWillChange, perform: { _ in
            print("hallo")
        })
    }
}

struct ButtonAreaView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData = SearchData()
    @Binding var localEventType: [EventType]
    

    func addOrRemoveEventTyoe(eventType: EventType) {
        if !localEventType.contains(eventType){
            self.addEventType(eventType: eventType)
        } else {
            self.removeEventType(eventType: eventType)
        }
        print(localEventType.count)
    }
    
    func addEventType(eventType: EventType) {
        if !localEventType.contains(eventType){
            localEventType.append(eventType)
        }
    }
    
    func removeEventType(eventType: EventType) {
        let removeIndex: Int = localEventType.firstIndex(of: eventType)!
        if localEventType.contains(eventType){
            localEventType.remove(at: removeIndex)
        }
    }
    
    func containsType(eventType: EventType) -> Bool {
        if localEventType.contains(eventType){
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
                        if localEventType.count == 0 {
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
//                                    .fontWeight(.semibold)
                        Text("Hier gibt es auch etwas Text")
                        .font(.avenirNextRegular(size: 14))
                        .fontWeight(.light)
//                                .foreground(gradientCherryPink)
                    }
                    Spacer()
                    EventTypeImage(imageString: "essen")
                        .saturation(localEventType.contains(.food) ? 1.0 : 0.0)
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
                        .saturation(localEventType.contains(.activity) ? 1.0 : 0.0)
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
                        .saturation(localEventType.contains(.sport) ? 1.0 : 0.0)
                        .padding(.leading, 5)
                
                }
                .padding(20)
                .frame(width: UIScreen.main.bounds.width)
            }
            
            Divider()
        }
    }
    
    
}

struct RequestView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData = SearchData()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func setNowPlus24() {
//        searchData.targetDate = Date().addingTimeInterval(86400)
        if searchData.isSearchActive {
            searchData.targetDate = Date().addingTimeInterval(10)
        } else {
            searchData.targetDate = Date().addingTimeInterval(20)
        }
    }

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
//        formatter.timeStyle = .long
        formatter.dateStyle = .short
        let dateString = formatter.string(from: searchData.created)
        return dateString
    }
    
    var body: some View {
        VStack() {
            
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
            
//            isSearchActive
//            Text("IS ACTIVE: \(searchData.isSearchActive ? "YES" : "NO")")
            
            HStack() {
                if secondsToHours(seconds: searchData.remainingTime) != 0 {
                    Text("Aktiv für die nächsten \(secondsToHours(seconds: searchData.remainingTime)):\(secondsToMinutes(seconds: searchData.remainingTime)):\(secondsToSeconds(seconds: searchData.remainingTime)) Stunden")
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.light)
                } else if secondsToHours(seconds: searchData.remainingTime) == 0 && secondsToMinutes(seconds: searchData.remainingTime) != 0{
                    Text("Aktiv für die nächsten \(secondsToMinutes(seconds: searchData.remainingTime)):\(secondsToSeconds(seconds: searchData.remainingTime)) Minuten")
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.light)
                } else {
                    Text("Aktiv für die nächsten \(secondsToSeconds(seconds: searchData.remainingTime)) Sekunden")
                            .font(.avenirNextRegular(size: 14))
                            .fontWeight(.light)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.bottom, 20)
            
            //BUTTON CNACEL
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.setNowPlus24()
                }
            }) {
                Text("Suche abbrechen")
                    .font(.avenirNextRegular(size: 22))
                    .foregroundColor(.red)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            
        }.onReceive(timer) { time in
            if self.searchData.remainingTime > 0 {
                self.searchData.remainingTime -= 1
            }
        }
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
