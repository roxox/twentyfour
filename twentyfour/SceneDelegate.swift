//
//  SceneDelegate.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import UIKit
import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var firebaseSession = FirebaseSession()
//    @EnvironmentObject var userData: UserData
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.

        var isReady: Bool = false
        
        // read current user
        let user = Auth.auth().currentUser
        
        // initialize Firebase
        let session = FirebaseSession()
        
        // WILL BE DELETED AS SOON AS POSSIBLE
        let userData = UserData()
        
        if user != nil {
        // initialize user values
        if session.publicUserData == nil {
            print("Loading Public User Data")
            session.getPublicUserDataByUID(user!.uid) { publicUserData in
                session.publicUserData = publicUserData
                
                    
                if session.ownSearch == nil {
                    print("Loading ownSearch")
                    session.getLastActiveOwnSearch{ search in
                        print("Search loaded: \(search?.id)")
                        isReady = true
                    }
                } else {
                    print("ownSearch available")
                    isReady = true
                }
            }
            
            if session.publicUserData != nil {
                session.isPublicUserDataAvailable = true
            }
        } else {
            print("Public User Data available")
        }
        
        if session.settings == nil {
            print("Loading Settings")
            session.getSettingsByUID(user!.uid)
        } else {
            print("Settings available")
        }
        
        if session.userDefaultValues == nil {
            print("Loading User Default Values")
            session.getUserDefaultValuesByUID(user!.uid)
        } else {
            print("User Default Values available")
        }
        
            session.getAllSearches() { searches in
                for item in session.activeSearches {
                    print("Gefundenes Datum: \(item.expireDate)")
                }
            }
        
        let locationManager = CLLocationManager()
        
//        let coordinates = locationManager.location?.coordinate
        
        let testCity = "Ellerhoop"
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(testCity) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                return
            }
            
//            lookUpCurrentLocation { name in
//                print(name?.locality ?? "no  name found")
//                print(name?.thoroughfare ?? "no  name found")
//                print(name?.name ?? "no  name found")
//                print(name?.location ?? "no  name found")
//                print(name?.region ?? "no  name found")
//                print(name?.administrativeArea ?? "no  name found")
//                print(name?.subThoroughfare ?? "no  name found")
//                print(name?.subLocality ?? "no  name found")
//                print(name?.subAdministrativeArea ?? "no  name found")
//                print(locationManager.location)
//            }
            
//            let localCoordinates = placemarks?.first?.location?.coordinate
            
//            let search = Search(user!.uid, Date(), Date(), localCoordinates!, true, true, true)
//            session.addSearch(search: search)
        }
        
        
        func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) {
                (placemarks, error) in
                guard error == nil else {
                    print("Geocoding error: \(error!)")
                    completion(nil)
                    return
                }
                completion(placemarks?.first?.location?.coordinate)
            }
        }
        
        func getCoordinate( addressString : String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressString) { (placemarks, error) in
                if error == nil {
                    if let placemark = placemarks?[0] {
                        let location = placemark.location!
                            
                        completionHandler(location.coordinate, nil)
                        return
                    }
                }
                    
                completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
            }
        }
        
        
        
//        getCoordinate(addressString: "Schulstieg 7, Ellerhoop") { coordinates, error  in
//            print(coordinates)
//        }
        
        func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                        -> Void ) {
            // Use the last reported location.
//            if let lastLocation = locationManager.location {
            if let lastLocation = locationManager.location {
                let geocoder = CLGeocoder()
                    
                // Look up the location and pass it to the completion handler
                geocoder.reverseGeocodeLocation(lastLocation,
                            completionHandler: { (placemarks, error) in
                    if error == nil {
                        let firstLocation = placemarks?[0]
                        completionHandler(firstLocation)
                    }
                    else {
                     // An error occurred during geocoding.
                        completionHandler(nil)
                    }
                })
            }
            else {
                // No location was available.
                completionHandler(nil)
            }
        }
        }
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(userData).environmentObject(session))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

