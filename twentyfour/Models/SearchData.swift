//
//  SearchData.swift
//  twentyfour
//
//  Created by Sebastian Fox on 10.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Combine

class SearchData: ObservableObject {
//    @Published var minOperatorValue: Double = 1
//
//
    @Published var locationString: String = UserDefaults.standard.string(forKey: "locationString") ?? "Los Angeles" {
        didSet {
            UserDefaults.standard.set(self.locationString, forKey: "locationString")
        }
    }

    @Published var maxDistance: Double = UserDefaults.standard.double(forKey: "maxDistance") {
        didSet {
            UserDefaults.standard.set(self.maxDistance, forKey: "maxDistance")
        }
    }

    @Published var targetDate: Date = UserDefaults.standard.object(forKey: "targetDate") as? Date ?? Date() {
        didSet {
            UserDefaults.standard.set(self.targetDate, forKey: "targetDate")
            self.calcRemainingTime()
        }
    }

    @Published var created: Date = UserDefaults.standard.object(forKey: "created") as? Date ?? Date() {
        didSet {
            UserDefaults.standard.set(self.created, forKey: "created")
        }
    }
    
    @Published var selectedEventTypes: [EventType] = [] {
        didSet {
            self.updateSelectedEvents()
        }
    }

    @Published var remainingTime: Int = UserDefaults.standard.integer(forKey: "remainingTime") {
        didSet {
            UserDefaults.standard.set(self.remainingTime, forKey: "remainingTime")
        }
    }
    
    var isSearchActive: Bool {
        if Date() < self.targetDate{
            return true
        }
        return false
    }
    
    
//
    init() {
        if self.maxDistance == 0 {
            self.maxDistance = 2
        }
        getSelectedEvents()
    }

    func updateSelectedEvents() {
        do {
            let data = try JSONEncoder().encode(self.selectedEventTypes)
            let string = String(data: data, encoding: .utf8)!
            UserDefaults.standard.set(string, forKey: "selectedEventTypes")
        } catch {
            print("Something went wrong")
        }
    }
//
    func getSelectedEvents() {
        let string = UserDefaults.standard.string(forKey: "selectedEventTypes")
        if string != nil {
            let data = string!.data(using: .utf8)!
            do {
                let result = try JSONDecoder().decode([EventType].self, from: data)
                for item in result {
                    self.selectedEventTypes.append(item)

                }
            } catch {
                print("Something went wrong!")
            }
        }
    }
    
    func calcRemainingTime() {
        
        let toDate = self.targetDate
        let fromDate = Date()
        let delta = toDate - fromDate // `Date` - `Date` = `TimeInterval`
        
         if delta < 0 {
            self.remainingTime = Int(0)
         } else {
             self.remainingTime = Int(delta) // `Date` + `TimeInterval` = `Date`
         }
    }
}
