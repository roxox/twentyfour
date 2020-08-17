//
//  FirebaseSession.swift
//  twentyfour
//
//  Created by Sebastian Fox on 19.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import UIKit
import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseSession: ObservableObject {
    var db: Firestore!
    
    //MARK: Properties
    @Published var currentUser: User?
    @Published var publicUserData: PublicUserData? // of current user
    @Published var privateUserData: PrivateUserData? // of current user
    @Published var settings: Settings?
    @Published var userDefaultValues: UserDefaultValues?
    @Published var searches: [Search] = []
    @Published var ownSearch: Search?
    {
        didSet {
//            if ownSearch != nil {
                saveOperations()
//            }
        }
    }
    
    
    @Published var isOwnSearchActive: Bool = UserDefaults.standard.bool(forKey: "isOwnSearchActive") {
        didSet {
            UserDefaults.standard.set(self.isOwnSearchActive, forKey: "isOwnSearchActive")
        }
    }
    
    @Published var users: [PublicUserData] = []
    @Published var groups: [UserGroup] = []
    
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged") {
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    
    @Published var isPublicUserDataAvailable: Bool = UserDefaults.standard.bool(forKey: "isPublicUserDataAvailable") {
        didSet {
            UserDefaults.standard.set(self.isPublicUserDataAvailable, forKey: "isPublicUserDataAvailable")
        }
    }
    
    @Published var isPrivateUserDataAvailable: Bool = UserDefaults.standard.bool(forKey: "isPrivateUserDataAvailable") {
        didSet {
            UserDefaults.standard.set(self.isPrivateUserDataAvailable, forKey: "isPrivateUserDataAvailable")
        }
    }
    
    init() {
        loadOperations()
    }
    
    
    func saveOperations() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.ownSearch) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "ownSearch")
        }
    }
    
    func loadOperations() {
        let defaults = UserDefaults.standard
        if let ownSearch = defaults.object(forKey: "ownSearch") as? Data {
            let decoder = JSONDecoder()
            if let loadedSearch = try? decoder.decode(Search.self, from: ownSearch) {
                print("xxx \(loadedSearch.id)")
                self.ownSearch = loadedSearch
            }
        }
    }
    
    var activeSearches: [Search] {
        searches.filter { $0.expireDate! >= Date() && $0.pubid
             == self.publicUserData?.id
        }
    }
    
//    var activeSearches: [Search] {
//        searches.filter {
//            if case Date() < $0.expireDate { return true }
//            return false
//        }
//    }
    
    // Authentication
    func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                self.currentUser = Auth.auth().currentUser
                self.isLogged = true
                self.getPublicUserDataByUID(self.currentUser!.uid) { publicUserData in
                    self.publicUserData = publicUserData
                }
            }
            
        }
    }
    
    func logOut() {
        try! Auth.auth().signOut()
        self.isLogged = false
        self.isPublicUserDataAvailable = false
        self.isPrivateUserDataAvailable = false
        self.currentUser = nil
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    // PUBLIC USER DATA
    func addPublicUserData(user: PublicUserData, completion: @escaping (PublicUserData?) -> Void) {
        db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        do {
            try db.collection("publicUserData").document(user.id!).setData(from: user)
            getPublicUserDataByUID(currentUser!.uid) { publicUserData in
                completion(publicUserData)
            }
            //            completion(self.publicUserData)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func getAllPublicUserData() {
        db.collection("publicUserData").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    
    func getPublicUserDataByID(_ id: String) {
        let docRef = db.collection("publicUserData").document(id)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: PublicUserData.self)
            }
            switch result {
            case .success(let user):
                if let user = user {
                    // A `User` value was successfully initialized from the DocumentSnapshot.
                    print("Public User Data loaded: \(user)")
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("Document does not exist")
                }
            case .failure(let error):
                // A `User` value could not be initialized from the DocumentSnapshot.
                print("Error decoding user: \(error)")
            }
        }
    }
    
    func getPublicUserDataByUID(_ uid: String, completion: @escaping (PublicUserData?) -> Void) {
        db = Firestore.firestore()
        db.collection("publicUserData").whereField("uid", isEqualTo: uid)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let docCount = querySnapshot!.documents.count
                    switch docCount {
                    case _ where docCount > 1:
                        print("Error, multible results found")
                    case 0:
                        print("No Public User Data available. Creating new profile")
                    default:
                        let document = querySnapshot!.documents.first
                        
                        let result = Result {
                            try document?.data(as: PublicUserData.self)
                        }
                        switch result {
                        case .success(let user):
                            if let user = user {
                                // A `User` value was successfully initialized from the DocumentSnapshot.
                                print("Public User Data loaded: \(user)")
                                publicUserData = user
                                self.isPublicUserDataAvailable = true
                                
                                completion(self.publicUserData)
                            } else {
                                // A nil value was successfully initialized from the DocumentSnapshot,
                                // or the DocumentSnapshot was nil.
                                print("Document does not exist")
                            }
                        case .failure(let error):
                            // A `User` value could not be initialized from the DocumentSnapshot.
                            print("Error decoding user: \(error)")
                        }
                    }
                }
            }
    }
    
    // SETTINGS
    func addSettings(settings: Settings) {
        db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        do {
            try db.collection("settings").document(settings.id!).setData(from: settings)
            getSettingsByUID(currentUser!.uid)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func updateSettings(_ settings: Settings) {
        
        do {
            try db.collection("settings").document(settings.id!).setData(from: settings)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func getSettingsByID(_ id: String) {
        let docRef = db.collection("settings").document(id)
        
        docRef.getDocument { (document, error) in
            let result = Result {
                try document?.data(as: Settings.self)
            }
            switch result {
            case .success(let settings):
                if let settings = settings {
                    // A `Settings` value was successfully initialized from the DocumentSnapshot.
                    print("Settings loaded: \(settings)")
                } else {
                    // A nil value was successfully initialized from the DocumentSnapshot,
                    // or the DocumentSnapshot was nil.
                    print("Document does not exist")
                }
            case .failure(let error):
                // A `Settings` value could not be initialized from the DocumentSnapshot.
                print("Error decoding user: \(error)")
            }
        }
    }
    
    func getSettingsByUID(_ uid: String) {
        db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        db.collection("settings").whereField("uid", isEqualTo: uid)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let docCount = querySnapshot!.documents.count
                    switch docCount {
                    case _ where docCount > 1:
                        print("Error, multible results found")
                    case 0:
                        print("No settings available. Creating new settings")
                        let settings = Settings(uid: currentUser!.uid)
                        self.addSettings(settings: settings)
                    //                        addUser
                    default:
                        let document = querySnapshot!.documents.first
                        
                        let result = Result {
                            try document?.data(as: Settings.self)
                        }
                        switch result {
                        case .success(let settings):
                            if let settings = settings {
                                // A `Settings` value was successfully initialized from the DocumentSnapshot.
                                print("Settings loaded: \(settings)")
                                self.settings = settings
                            } else {
                                // A nil value was successfully initialized from the DocumentSnapshot,
                                // or the DocumentSnapshot was nil.
                                print("Document does not exist")
                            }
                        case .failure(let error):
                            // A `Settings` value could not be initialized from the DocumentSnapshot.
                            print("Error decoding user: \(error)")
                        }
                    }
                }
            }
    }
    
    // User Default Values
    func addUserDefaultValues(userDefaultValues: UserDefaultValues) {
        db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        do {
            try db.collection("userDefaultValues").document(userDefaultValues.id!).setData(from: userDefaultValues)
            getUserDefaultValuesByUID(currentUser!.uid)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func updateUserDefaultValues(_ userDefaultValues: UserDefaultValues) {
        
        // Get firestore docRef
//        let docRef = db.collection("userDefaultValues").document(userDefaultValues.id!)
        
        
            
            do {
                try db.collection("userDefaultValues").document(userDefaultValues.id!).setData(from: userDefaultValues)
            } catch let error {
                print("Error writing user to Firestore: \(error)")
            }
        }
    
    
        // update via representation
//        docRef.updateData(userDefaultValues.representation) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
//    }
    
    func getUserDefaultValuesByUID(_ uid: String) {
        db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        db.collection("userDefaultValues").whereField("uid", isEqualTo: uid)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let docCount = querySnapshot!.documents.count
                    switch docCount {
                    case _ where docCount > 1:
                        print("Error, multible results found")
                    case 0:
                        print("No userDefaultValues available. Creating new settings")
                        let userDefaultValues = UserDefaultValues(uid: currentUser!.uid)
                        self.addUserDefaultValues(userDefaultValues: userDefaultValues)
                    //                        addUser
                    default:
                        let document = querySnapshot!.documents.first
                        
                        let result = Result {
                            try document?.data(as: UserDefaultValues.self)
                        }
                        switch result {
                        case .success(let userDefaultValues):
                            if let userDefaultValues = userDefaultValues {
                                // A `Settings` value was successfully initialized from the DocumentSnapshot.
                                print("UserDefaultValues loaded: \(userDefaultValues)")
                                self.userDefaultValues = userDefaultValues
                            } else {
                                // A nil value was successfully initialized from the DocumentSnapshot,
                                // or the DocumentSnapshot was nil.
                                print("Document does not exist")
                            }
                        case .failure(let error):
                            // A `Settings` value could not be initialized from the DocumentSnapshot.
                            print("Error decoding user: \(error)")
                        }
                    }
                }
            }
    }
    
    // Searches
    func addSearch(search: Search, completion: @escaping (Search?) -> Void) {
        db = Firestore.firestore()
        
        do {
            try db.collection("searches").document(search.id!).setData(from: search)
            completion(search)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    func getSearchesByUID(_ uid: String) {
        db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        db.collection("searches").whereField("uid", isEqualTo: uid)
            .getDocuments() { [self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let docCount = querySnapshot!.documents.count
                    switch docCount {
                    case _ where docCount > 1:
                        print("Error, multible results found")
                    case 0:
                        print("No settings available. Creating new settings")
                        let settings = Settings(uid: currentUser!.uid)
                        self.addSettings(settings: settings)
                    //                        addUser
                    default:
                        let document = querySnapshot!.documents.first
                        
                        let result = Result {
                            try document?.data(as: Settings.self)
                        }
                        switch result {
                        case .success(let settings):
                            if let settings = settings {
                                // A `Settings` value was successfully initialized from the DocumentSnapshot.
                                print("Settings loaded: \(settings)")
                                self.settings = settings
                            } else {
                                // A nil value was successfully initialized from the DocumentSnapshot,
                                // or the DocumentSnapshot was nil.
                                print("Document does not exist")
                            }
                        case .failure(let error):
                            // A `Settings` value could not be initialized from the DocumentSnapshot.
                            print("Error decoding user: \(error)")
                        }
                    }
                }
            }
    }
    
    func getAllSearches(completion: @escaping ([Search]?) -> Void) {
        db = Firestore.firestore()
        db.collection("searches")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var searches: [Search] = []
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: Search.self)
                        }
                        switch result {
                            case .success(let search):
                                if let search = search {
                                    // A `Search` value was successfully initialized from the DocumentSnapshot.
                                    print("Search found: \(search)")
                                    if !searches.contains(search) {
                                        searches.append(search)
                                    }
                                    if !self.searches.contains(search) {
                                        self.searches.append(search)
                                    }
                                } else {
                                    // A nil value was successfully initialized from the DocumentSnapshot,
                                    // or the DocumentSnapshot was nil.
                                    print("Document does not exist")
                                }
                            case .failure(let error):
                                // A `City` value could not be initialized from the DocumentSnapshot.
                                print("Error decoding city: \(error)")
                            }
                    }
                    completion(searches)
                }
            }
    }
    
    func getAllActiveSearches(completion: @escaping ([Search]?) -> Void) {
        
        db = Firestore.firestore()
        db.collection("searches").whereField("expireDate", isGreaterThan: Date())
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var searches: [Search] = []
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: Search.self)
                        }
                        switch result {
                            case .success(let search):
                                if let search = search {
                                    // A `Search` value was successfully initialized from the DocumentSnapshot.
                                    print("Search found: \(search)")
                                    if !searches.contains(search) {
                                        searches.append(search)
                                    }
                                    if !self.searches.contains(search) {
                                        self.searches.append(search)
                                    }
                                } else {
                                    // A nil value was successfully initialized from the DocumentSnapshot,
                                    // or the DocumentSnapshot was nil.
                                    print("Document does not exist")
                                }
                            case .failure(let error):
                                // A `City` value could not be initialized from the DocumentSnapshot.
                                print("Error decoding city: \(error)")
                            }
                    }
                    completion(searches)
                }
            }
    }
    
    func getAllActiveOwnSearches(completion: @escaping ([Search]?) -> Void) {
        
        db = Firestore.firestore()
        db.collection("searches").whereField("expireDate", isGreaterThan: Date()).whereField("pubid", isEqualTo: self.publicUserData?.id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var searches: [Search] = []
                    for document in querySnapshot!.documents {
                        let result = Result {
                            try document.data(as: Search.self)
                        }
                        switch result {
                            case .success(let search):
                                if let search = search {
                                    // A `Search` value was successfully initialized from the DocumentSnapshot.
                                    print("Search found: \(search)")
                                    if !searches.contains(search) {
                                        searches.append(search)
                                    }
                                    if !self.searches.contains(search) {
                                        self.searches.append(search)
                                    }
                                } else {
                                    // A nil value was successfully initialized from the DocumentSnapshot,
                                    // or the DocumentSnapshot was nil.
                                    print("Document does not exist")
                                }
                            case .failure(let error):
                                // A `City` value could not be initialized from the DocumentSnapshot.
                                print("Error decoding city: \(error)")
                            }
                    }
                    completion(searches)
                }
            }
    }
    
    func getLastActiveOwnSearch(completion: @escaping (Search?) -> Void) {
        
        db = Firestore.firestore()
        db.collection("searches").whereField("expireDate", isGreaterThan: Date()).whereField("pubid", isEqualTo: self.publicUserData?.id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    if querySnapshot!.documents.count > 0 {
                        let document = querySnapshot!.documents.last
                        
                        let result = Result {
                            try document!.data(as: Search.self)
                        }
                        switch result {
                            case .success(let search):
                                if let search = search {
                                    // A `Search` value was successfully initialized from the DocumentSnapshot.
                                    print("Search found: \(search)")
                                    self.ownSearch = search
                                    completion(search)
                                } else {
                                    // A nil value was successfully initialized from the DocumentSnapshot,
                                    // or the DocumentSnapshot was nil.
                                    print("Document does not exist")
                                    completion(nil)
                                }
                            case .failure(let error):
                                // A `City` value could not be initialized from the DocumentSnapshot.
                                print("Error decoding city: \(error)")
                            }
                    } else {
                        self.ownSearch = nil
                        completion(nil)
                    }
                }
            }
    }
    
    // USERGROUPS
    func addUserGroup(group: UserGroup) {
        db = Firestore.firestore()
        do {
            try db.collection("userGroups").document(group.id!).setData(from: group)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
        }
    }
    
    //MARK: Functions
    //    func listen() {
    //        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
    //            if let user = user {
    //                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
    //                self.isLoggedIn = true
    //                self.getTODOS()
    //            } else {
    //                self.isLoggedIn = false
    //                self.session = nil
    //            }
    //        }
    //    }
    
    
}
