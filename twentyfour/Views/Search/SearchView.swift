//
//  SearchView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 11.05.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import MapKit
import Combine

struct ActivityTypeToggleHandler {
    var isFoodToggle: Bool = false {
        didSet {
            self.isFoodToggleWillChange.send(isFoodToggle)
        }
    }
    var isLeisureToggle: Bool = false {
        didSet {
            self.isLeisureToggleWillChange.send(isLeisureToggle)
        }
    }
    var isSportsToggle: Bool = false {
        didSet {
            self.isSportsToggleWillChange.send(isSportsToggle)
        }
    }
    
    public let isFoodToggleWillChange = PassthroughSubject<Bool,Never>()
    public let isLeisureToggleWillChange = PassthroughSubject<Bool,Never>()
    public let isSportsToggleWillChange = PassthroughSubject<Bool,Never>()
}
struct SearchView: View {
    
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var session: FirebaseSession
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var searchData: SearchData
    @State var isFocused = false
    @State var keyboardHeight = CGFloat (0)
    @State var showKeyboard = false
    @State var remainingTime: Int = 0
    
    // Temporary values
    @State var tmpLocationString: String = ""
    @State var tmpMaxDistance: Double = 2
    @State var tmpEventTypes: [ActivityType] = []
    @State var tmpLocation: CLLocationCoordinate2D?
    @State var isFoodToggle: Bool = false
    @State var isLeisureToggle: Bool = false
    @State var isSportToggle: Bool = false
    
    @State var toggleHandler = ActivityTypeToggleHandler()
    
    func addEventType(activityType: ActivityType) {
        if !self.tmpEventTypes.contains(activityType){
            self.tmpEventTypes.append(activityType)
        }
    }
    
    func removeEventType(activityType: ActivityType) {
        if self.tmpEventTypes.contains(activityType){
            let removeIndex: Int = self.tmpEventTypes.firstIndex(of: activityType)!
            self.tmpEventTypes.remove(at: removeIndex)
        }
    }
    
    fileprivate let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    func closeSearchView() {
        hideKeyboard()
        searchData.scrollSearchMenuToTop = true
        presentationMode.wrappedValue.dismiss()
    }
    
    func getCurrentLocation() {
        globalLookUpCurrentLocation { loc in
            tmpLocationString = (loc?.locality)!
            tmpLocation = loc?.location?.coordinate
        }
    }
    
    
    func initializeTmpValues() {
        if session.ownSearch != nil {
            let currentSearch: Search = session.ownSearch!
            self.tmpLocation = currentSearch.location
            self.tmpLocationString = currentSearch.locationName ?? ""
            self.tmpMaxDistance = currentSearch.maxDistance ?? 2
            self.isFoodToggle = currentSearch.isFoodSelected!
            self.isLeisureToggle = currentSearch.isLeisureSelected!
            self.isSportToggle = currentSearch.isSportSelected!
        } else{
            self.tmpLocation = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
            self.tmpLocationString = ""
            self.tmpMaxDistance = 2.0
            self.isFoodToggle = false
            self.isLeisureToggle = false
            self.isSportToggle = false
        }
        
//        if self.tmpEventTypes.contains(.food) {
//            self.toggleHandler.isFoodToggle = true
//        } else {
//            self.toggleHandler.isFoodToggle = false
//        }
//        if self.tmpEventTypes.contains(.leisure) {
//            self.toggleHandler.isLeisureToggle = true
//        } else {
//            self.toggleHandler.isLeisureToggle = false
//        }
//        if self.tmpEventTypes.contains(.sports) {
//            self.toggleHandler.isSportsToggle = true
//        } else {
//            self.toggleHandler.isSportsToggle = false
//        }
    }
    
    func isModified() -> Bool {
        if self.tmpLocationString != searchData.locationString {
            return true
        }
        
        if self.tmpMaxDistance != searchData.maxDistance {
            return true
        }
        
        
        if self.tmpEventTypes != searchData.eventTypes {
            return true
        }
        
        return false
    }
    
    func saveValues() {
//        if session.activeSearches.count != 0 {
//            var currentSearch = session.activeSearches.first
//            currentSearch?.location = tmpLocation
//            currentSearch?.maxDistance = tmpMaxDistance
//            
//            // update firebase entity
//        } else {
//            let currentSearch: Search = Search(
//                (session.publicUserData?.id)!,
//                Date(),
//                Date() + 86400,
//                tmpLocation!,
//                true,
//                true,
//                true,
//                tmpMaxDistance
//            )
//            // create firebase entity
//            session.addSearch(search: currentSearch)
//        }
        searchData.copyTmpValuesToValues(tmpLocationString: tmpLocationString, tmpMaxDistance: tmpMaxDistance, tmpEventTypes: tmpEventTypes)
        self.searchData.createOrUpdate()
        
        self.closeSearchView()
        
        self.searchData.createOrUpdate()
        self.closeSearchView()
    }
    
    func getDistanceUnitString(_ value: DistanceUnit) -> String {
        switch value {
        case .kilometres:
            return "km"
        case .miles:
            return "mi"
        }
    }
    
    func getLabel() -> String {
        if self.remainingTime > 0 {
            return "Speichern"
        }
        return "Erstellen"
    }
    
    var body: some View {
//        GeometryReader { geometry in
            ZStack() {
                //                VStack() {
                ScrollView(showsIndicators: false) {
                    ScrollViewReader { scrollView in
                        VStack(){
                            HStack() {
                                Rectangle().fill(Color .clear)
                                    .id("top")
                                    .frame(height: 30)
                                    .frame(maxWidth: .infinity)
                            }
                            
                            Group {
                                HStack() {
                                    Text("Standort")
                                        .font(.avenirNextRegular(size: 20))
                                        .fontWeight(.medium)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                
                                
//                                if session.settings!.showInfoTexts {
                                    HStack() {
                                        Text("Wähle zunächst den Ort ,wo du etwas unternehmen möchtest. Entweder direkt in deiner Umgebung, aber wenn du heute Abedn ganz woanders bist, suche einfach dort.")
                                            .font(.avenirNextRegular(size: 16))
                                            .fontWeight(.light)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.top, 10)
//                                }
                                
                                HStack(alignment: .top) {
                                    Image("locationBlack")
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width: 20, height: 20)
                                        .scaledToFill()
                                        .foreground(Color ("button1"))
                                    
                                    VStack(alignment: .leading) {
                                        Text("Ort")
                                            .font(.avenirNextRegular(size: 12))
                                            .fontWeight(.semibold)
                                        TextField("Wo willst du etwas unternehmen?", text: self.$tmpLocationString)
                                            .font(.avenirNextRegular(size: 18))
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
                                .padding(.bottom, 2)
                                
                                HStack() {
                                    
                                    Button(action: {
                                        withAnimation(.linear(duration: 0.2)) {
                                            getCurrentLocation()
                                        }
                                    }) {
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
                                        .background(Color ("SuperLightGray"))
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, 45)
                                .padding(.top, 5)
                                
                                
                                
                                HStack(alignment: .top) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(Color ("button1"))
                                        .fixedSize()
                                        .frame(width: 20, height: 20)
                                    
                                    VStack(alignment: .leading) {
                                        Text("max. Enterfernung")
                                            .font(.avenirNextRegular(size: 12))
                                            .fontWeight(.semibold)
                                    }
                                    Spacer()
                                    
                                    Text("\(Int(self.tmpMaxDistance))")
                                    Text("\(getDistanceUnitString(session.settings!.distanceUnit))")
//                                    .padding(.trailing, 40)
                                    
//                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 10)
                                .padding(.bottom, 2)
                                
                                HStack() {
                                    Slider(value: self.$tmpMaxDistance, in: 2...50, step: 1)
                                        .accentColor(.pink)
                                }
                                .padding(.horizontal, 50)
                                .padding(.bottom, 20)
                                
                                Divider()
                            }
                            
                            Group {
                                
                                HStack() {
                                    //                        Spacer()
                                    Text("Aktivität")
                                        .font(.avenirNextRegular(size: 20))
                                        .fontWeight(.medium)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .lineLimit(1)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                
                                
                                
//                                if session.settings!.showInfoTexts {
                                    HStack() {
                                        Text("Wähle zunächst den Ort ,wo du etwas unternehmen möchtest. Entweder direkt in deiner Umgebung, aber wenn du heute Abedn ganz woanders bist, suche einfach dort.")
                                            .font(.avenirNextRegular(size: 16))
                                            .fontWeight(.light)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.top, 10)
//                                }
                                
                                HStack() {
                                    
                                    Image(systemName: "moon.stars")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(Color ("button1"))
                                        .fixedSize()
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 10)
                                    
                                    HStack() {
                                        VStack(alignment: .leading){
                                            Text("Essen & Trinken")
                                                .font(.avenirNextRegular(size: 16))
                                                .fontWeight(.semibold)
                                            Text("Hier gibt es auch etwas Text")
                                                .font(.avenirNextRegular(size: 14))
                                                .fontWeight(.light)
                                        }
                                        
                                        Spacer()
                                    }.frame(maxWidth: .infinity)
                                    
                                    Toggle("", isOn: $isFoodToggle)
                                        .labelsHidden()
                                        .padding()
                                }
                                .toggleStyle(SwitchToggleStyle(tint: Color .pink))
                                .padding(.leading, 20)
                                
                                HStack() {
                                    
                                    //                EventTypeImage(imageString: "freizeit2")
                                    //                    .padding(.leading, 5)
                                    //                    .padding(.trailing, 10)
                                    
                                    Image(systemName: "guitars")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(Color ("button1"))
                                        .fixedSize()
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 10)
                                    
                                    HStack() {
                                        VStack(alignment: .leading){
                                            Text("Freizeit")
                                                .font(.avenirNextRegular(size: 16))
                                                .fontWeight(.semibold)
                                            Text("Ganz viel neuer Text könnte hier drinstehen, um die EventTypes zu erläutern.")
                                                .font(.avenirNextRegular(size: 14))
                                                .fontWeight(.light)
                                        }
                                        Spacer()
                                    }.frame(maxWidth: .infinity)
                                    
                                    Toggle("", isOn: $isLeisureToggle)
                                        .labelsHidden()
                                        .padding()
                                }
                                .toggleStyle(SwitchToggleStyle(tint: Color .pink))
                                .padding(.leading, 20)
                                
                                HStack() {
                                    
                                    //                EventTypeImage(imageString: "sport")
                                    //                    .padding(.leading, 5)
                                    //                    .padding(.trailing, 10)
                                    Image(systemName: "sportscourt")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(Color ("button1"))
                                        .fixedSize()
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 10)
                                    
                                    HStack() {
                                        VStack(alignment: .leading){
                                            Text("Sport")
                                                .font(.avenirNextRegular(size: 16))
                                                .fontWeight(.semibold)
                                            Text("Und noch einmal: Ganz viel neuer Text könnte hier drinstehen, um die EventTypes zu erläutern.")
                                                .font(.avenirNextRegular(size: 14))
                                                .fontWeight(.light)
                                        }
                                        Spacer()
                                    }.frame(maxWidth: .infinity)
                                    
                                    Toggle("", isOn: $isSportToggle)
                                        .labelsHidden()
                                        .padding()
                                }
                                .toggleStyle(SwitchToggleStyle(tint: Color .pink))
                                .padding(.leading, 20)
                                
                                Divider()
                            }
                            
                            //                            ButtonAreaView(searchData: self.searchData, tmpEventTypes: self.$tmpEventTypes)
                            if (self.session.ownSearch != nil){
                                if (self.session.ownSearch?.expireDate)! > Date() {
                                    RequestView(searchData: self.searchData)
                                        .padding(.bottom, 80)
                                }
                            }
                        }
                        .onReceive(self.searchData.scrollSearchMenuToTopWillChange) { newValue in
                            if newValue == true {
                                withAnimation(.linear(duration: 0.2)) {
                                    scrollView.scrollTo("top", anchor: .bottom)
                                    self.searchData.scrollSearchMenuToTop = false
                                }
                            }
                        }
                    }
                    .background(Color ("background1"))
                    .foregroundColor(Color ("button1"))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.top, 25)
                }
                .background(Color ("background1"))
                
                //                Rectangle().fill(Color .clear)
                //                    .frame(height: 30)
                //                }
                
                // OVERLAY MIT MENU
                SearchHeaderOverlay(
                    searchData: searchData,
                    tmpLocationString: $tmpLocationString,
                    tmpMaxDistance: $tmpMaxDistance,
                    tmpEventTypes: $tmpEventTypes,
                    tmpLocation: $tmpLocation,
                    isFoodToggle: $isFoodToggle,
                    isLeisureToggle: $isLeisureToggle,
                    isSportToggle: $isSportToggle)
                
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
                            
//                            .onAppear() {
//                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti)  in
//
//                                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//                                    let height = value.height
//
//                                    self.keyboardHeight = height
//                                    self.showKeyboard = true
//                                }
//
//                                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti)  in
//                                    self.keyboardHeight = 0
//                                    self.showKeyboard = false
//                                }
//                            }
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
            .onReceive(self.searchData.remainingTimeWillChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    self.remainingTime = newValue
                }
            }
//            .onReceive(self.searchData.eventTypesWillChange) { newValue in
//                withAnimation(.linear(duration: 0.2)) {
//                    self.tmpEventTypes = newValue
//                }
//            }
//            .onReceive(self.searchData.locationStringWillChange) { newValue in
//                withAnimation(.linear(duration: 0.2)) {
//                    self.tmpLocationString = newValue
//                }
//            }
//            .onReceive(self.searchData.maxDistanceWillChange) { newValue in
//                withAnimation(.linear(duration: 0.2)) {
//                    self.tmpMaxDistance = newValue
//                }
//            }
            .onAppear() {
                self.initializeTmpValues()
            }
            
            .onReceive(self.toggleHandler.isFoodToggleWillChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    if newValue == true {
                        self.addEventType(activityType: .food)
                    } else {
                        self.removeEventType(activityType: .food)
                    }
                }
            }
            
            .onReceive(self.toggleHandler.isLeisureToggleWillChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    if newValue == true {
                        self.addEventType(activityType: .leisure)
                    } else {
                        self.removeEventType(activityType: .leisure)
                    }
                }
            }
            
            .onReceive(self.toggleHandler.isSportsToggleWillChange) { newValue in
                withAnimation(.linear(duration: 0.2)) {
                    if newValue == true {
                        self.addEventType(activityType: .sports)
                    } else {
                        self.removeEventType(activityType: .sports)
                    }
                }
            }
            
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
            
            .animation(.spring())
//            .navigationBarHidden(true)
//            .navigationBarTitle("", displayMode: .inline)
//            .navigationBarBackButtonHidden(true)
//        }
    }
}

struct RequestView: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData: SearchData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
        let dateString = formatter.string(from: searchData.created)
        return dateString
    }
    
    func cancel() {
        self.searchData.cancel()
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack() {
            
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
            
            
            // Abbrechen
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.cancel()
                }
            }) {
                HStack() {
                    Text("Suche abbrechen")
                        .font(.avenirNextRegular(size: 16))
                        .fontWeight(.semibold)
                        .padding(.trailing)
                }
                .frame(height: 30)
                .foreground(gradientPinkPinkAndPeach)
            }
            .padding(.horizontal, 20)
        }
        .onReceive(self.searchData.remainingTimeWillChange) { newValue in
            withAnimation(.linear(duration: 0.2)) {
                self.remainingTime = newValue
            }
        }
        .animation(.spring())
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct ActivityTypeImage: View {
    
    let imageString: String
    var body: some View {
        
        Image(imageString)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 45 ,height: 45)
            .overlay(Circle().stroke(gradientBlueAccentSea, lineWidth: 1))
    }
}

struct SearchHeaderOverlay: View {
    
    @EnvironmentObject var userData: UserData
    @ObservedObject var searchData: SearchData
    @EnvironmentObject var session: FirebaseSession
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var tmpLocationString: String
    @Binding var tmpMaxDistance: Double
    @Binding var tmpEventTypes: [ActivityType]
    @Binding var tmpLocation: CLLocationCoordinate2D?
    @Binding var isFoodToggle: Bool
    @Binding var isLeisureToggle: Bool
    @Binding var isSportToggle: Bool
    
    func closeSearchView() {
        hideKeyboard()
        searchData.scrollSearchMenuToTop = true
        presentationMode.wrappedValue.dismiss()
    }
    
    func isModified() -> Bool {
        if self.session.ownSearch != nil {
            if self.tmpLocationString != String((session.ownSearch?.locationName)!) {
                return true
            }
            
            if self.tmpMaxDistance != session.ownSearch?.maxDistance {
                return true
            }
            
            if self.isFoodToggle != session.ownSearch?.isFoodSelected {
                return true
            }
            
            if self.isLeisureToggle != session.ownSearch?.isLeisureSelected {
                return true
            }
            
            if self.isSportToggle != session.ownSearch?.isSportSelected {
                return true
            }
        } else {
            return true
        }
        
//        if self.tmpEventTypes != searchData.eventTypes {
//            return true
//        }
        
        return false
    }
    
    func saveValues() {
        
        tmpLocation = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
            if session.ownSearch != nil {
                var currentSearch = session.ownSearch
                currentSearch?.location = tmpLocation
                currentSearch?.maxDistance = tmpMaxDistance
                currentSearch?.isFoodSelected = isFoodToggle
                currentSearch?.isLeisureSelected = isLeisureToggle
                currentSearch?.isSportSelected = isSportToggle
                
                session.addSearch(search: currentSearch!) { search in
                    session.ownSearch = search
                }
                // update firebase entity
            } else {
                let currentSearch: Search = Search(
                    (session.publicUserData?.id)!,
                    Date(),
                    Date() + 86400,
                    tmpLocation!,
                    tmpLocationString,
                    isFoodToggle,
                    isLeisureToggle,
                    isSportToggle,
                    tmpMaxDistance
                )
                
                // create firebase entity
                session.addSearch(search: currentSearch) { search in
                    session.ownSearch = search
                }
            }
        
        session.getAllActiveSearches { searches in
            
        }
        
        
//        searchData.copyTmpValuesToValues(tmpLocationString: tmpLocationString, tmpMaxDistance: tmpMaxDistance, tmpEventTypes: tmpEventTypes)
//        self.searchData.createOrUpdate()
        presentationMode.wrappedValue.dismiss()
    }
    
//    func getActivityString(eventType: ActivityType) -> String {
//        switch eventType {
//        case .food:
//            return "Essen und Trinken"
//        case .leisure:
//            return "Freizeit"
//        case .sports:
//            return "Sport"
//        }
//    }
//
//    func generateActivityString(eventTypes: [ActivityType]) -> String {
//        var returnString: String = ""
//        for activityType in eventTypes {
//            returnString.append(getActivityString(eventType: activityType))
//        }
//        return returnString
//    }
    
    var body: some View {
        
        GeometryReader { geometry in
            // OVERLAY MIT MENU
            VStack() {
                Group {
                VStack(){
                    Rectangle().fill(Color ("background1"))
                        .frame(height: geometry.safeAreaInsets.top)
                    ZStack() {
                        HStack() {
                            
                            // CANCEL BUTTON
                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    self.closeSearchView()
                                }
                            }) {
                                HStack(){
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 14, weight: .medium))
                                        .frame(width: 18, height: 18)
                                }
                            }
                            .frame(height: 36)
                            .foregroundColor(Color ("button1"))
                            
                            Spacer()
                            
                            
                            Spacer()
             
//                            Text("\(self.session.ownSearch != nil ? "ändern" : "erstellen")")
//                                .font(.avenirNextRegular(size: 15))
//                                .fontWeight(.bold)
//                                .underline()
                            
                            
                            Button(action: {
                                withAnimation(.linear(duration: 0.2)) {
                                    self.saveValues()
                                }
                            }) {
                                HStack() {
                                    Text("\(self.session.ownSearch != nil ? "ändern" : "erstellen")")
                                        .font(.avenirNextRegular(size: 15))
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                        .underline()
                                }
//                                .frame(height: 40)
//    //                            .background(gradientPeachPink)
//                                .background(gradientCherryPink)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .disabled(!self.isModified() || self.tmpLocationString == "")
                            .saturation(!self.isModified() || self.tmpLocationString == "" ? 0.2 : 1)
                            .opacity(!self.isModified() || self.tmpLocationString == "" ? 0.2 : 1)
//                            .padding(.horizontal, 20)
                            
                            
                        }
                        .padding(.horizontal, 20)
                        
                        
                        HStack(alignment: .center){
                            Spacer()
                            Text("Deine Suche / Inserat")
                                .font(.avenirNextRegular(size: 15))
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }
                    
//                    Divider()
                }
                .background(Color ("background1"))
                .edgesIgnoringSafeArea(.top)
                }
                
                Spacer()
                
//                Group {
//                VStack() {
//                    
//                    Divider()
//                    
//                    HStack() {
//                        
////                        VStack(alignment: .leading){
////                            Text(tmpLocationString != "" ? tmpLocationString + " (+ max. " + String(Int(tmpMaxDistance)) + "km)" : "Wähle einen Ort, wo du etwas unternehmen möchtest")
////                                .font(.avenirNextRegular(size: 13))
////                                .fontWeight(.semibold)
////                                .foregroundColor(tmpLocationString != "" ? Color ("button1") : Color .pink)
////                            
//////                            HStack(){
//////                                Text(generateActivityString(tmpEventTypes))
//////                            }
////                        }
////                        .padding(.leading, 20)
//                        
//                        Spacer()
//                        
//                        Button(action: {
//                            withAnimation(.linear(duration: 0.2)) {
//                                self.saveValues()
//                            }
//                        }) {
//                            HStack() {
//                                Text("\(self.session.ownSearch != nil ? "ändern" : "erstellen")")
//                                    .font(.avenirNextRegular(size: 14))
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal)
//                            }
//                            .frame(height: 40)
////                            .background(gradientPeachPink)
//                            .background(gradientCherryPink)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        }
//                        .disabled(!self.isModified() || self.tmpLocationString == "")
//                        .saturation(!self.isModified() || self.tmpLocationString == "" ? 0.2 : 1)
//                        .opacity(!self.isModified() || self.tmpLocationString == "" ? 0.2 : 1)
//                        .padding(.horizontal, 20)
//                        
//                    }
//                    
//                    
//                    Rectangle().fill(Color ("background1"))
//                        .frame(height: geometry.safeAreaInsets.bottom)
//                    
//                }
//                .background(Color ("background1"))
//                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
}
