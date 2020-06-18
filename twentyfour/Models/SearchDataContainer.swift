//
//  SearchData.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Combine

class SearchDataContainer: ObservableObject {
    
    @Published var locationString: String = UserDefaults.standard.string(forKey: "locationString") ?? "" {
        didSet {
            self.locationStringWillChange.send(locationString)
            UserDefaults.standard.set(self.locationString, forKey: "locationString")
        }
    }

    @Published var maxDistance: Double = UserDefaults.standard.double(forKey: "maxDistance") {
        didSet {
            self.maxDistanceWillChange.send(maxDistance)
            UserDefaults.standard.set(self.maxDistance, forKey: "maxDistance")
        }
    }

    @Published var targetDate: Date = UserDefaults.standard.object(forKey: "targetDate") as? Date ?? Date() {
        didSet {
            self.targetDateWillChange.send(targetDate)
            UserDefaults.standard.set(self.targetDate, forKey: "targetDate")
//            self.getRemainingTime()
        }
    }

    @Published var created: Date = UserDefaults.standard.object(forKey: "created") as? Date ?? Date() {
        didSet {
            self.createdDateWillChange.send(created)
            UserDefaults.standard.set(self.created, forKey: "created")
        }
    }

    @Published var currentTime: Date = UserDefaults.standard.object(forKey: "currentTime") as? Date ?? Date() {
        didSet {
            self.currentTimeWillChange.send(currentTime)
            self.remainingTimeWillChange.send(calcRemainingTime())
            UserDefaults.standard.set(self.currentTime, forKey: "currentTime")
        }
    }
    
    @Published var eventTypes: [EventType] = [] {
        didSet {
            self.eventTypesWillChange.send(eventTypes)
            self.updateSelectedEvents()
        }
    }

    @Published var remainingTime: Int = UserDefaults.standard.integer(forKey: "remainingTime")
        {
        willSet {
            self.objectWillChange.send()
        }
        didSet {
            UserDefaults.standard.set(self.remainingTime, forKey: "remainingTime")
        }
    }
    
    @Published var isSearchActive: Bool = false
//        {
//           willSet {
//               objectWillChange.send(newValue)
//           }
//       }
    
//
    init() {
        if self.maxDistance == 0 {
            self.maxDistance = 2
        }
        getEventTypes()
    }
    
    public let targetDateWillChange = PassthroughSubject<Date,Never>()
    
    public let createdDateWillChange = PassthroughSubject<Date,Never>()
    
    public let currentTimeWillChange = PassthroughSubject<Date,Never>()
    
    public let remainingTimeWillChange = PassthroughSubject<Int,Never>()
    
    public let locationStringWillChange = PassthroughSubject<String,Never>()
    
    public let maxDistanceWillChange = PassthroughSubject<Double,Never>()
    
    public let eventTypesWillChange = PassthroughSubject<[EventType],Never>()

    func updateSelectedEvents() {
        do {
            let data = try JSONEncoder().encode(self.eventTypes)
            let string = String(data: data, encoding: .utf8)!
            UserDefaults.standard.set(string, forKey: "eventTypes")
        } catch {
            print("Something went wrong")
        }
    }
//
    func getEventTypes() {
        let string = UserDefaults.standard.string(forKey: "eventTypes")
        if string != nil {
            let data = string!.data(using: .utf8)!
            do {
                let result = try JSONDecoder().decode([EventType].self, from: data)
                for item in result {
                    self.eventTypes.append(item)

                }
            } catch {
                print("Something went wrong!")
            }
        }
    }

    func calcRemainingTime() -> Int{

        let toDate = self.targetDate
        let fromDate = Date()
        let delta = toDate - fromDate // `Date` - `Date` = `TimeInterval`

         if delta <= 0 {
            return Int(0)
         } else {
             return Int(delta) // `Date` + `TimeInterval` = `Date`
         }
    }

    func timerEvent() {
        if remainingTime != 0 {
            remainingTime -= 1
            isSearchActive = true
        } else {
            isSearchActive = false
        }
    }

    func startTimer() {
        self.created = Date()
        self.targetDate = created + 86400
//        self.targetDate = created + 20
    }

    func extendTimer() {
//        self.targetDate = created + 86400
        self.targetDate = targetDate + 20
    }
    
    func createOrUpdate() {
        if self.targetDate < self.currentTime {
            self.startTimer()
        }
    }
    
    func cancel() {
        self.targetDate = Date()
    }
    
    func resetValues() {
        locationString = ""
        maxDistance = 2
        eventTypes = []
    }
    
    func copyTmpValuesToValues(tmpLocationString: String, tmpMaxDistance: Double, tmpEventTypes: [EventType]) {
        locationString = tmpLocationString
        maxDistance = tmpMaxDistance
        
        eventTypes.removeAll()
        eventTypes.append(contentsOf: tmpEventTypes)
    }
}
