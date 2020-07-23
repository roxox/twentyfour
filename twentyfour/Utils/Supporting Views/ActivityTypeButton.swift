//
//  ActivityTypeButton.swift
//  twentyfour
//
//  Created by Sebastian Fox on 03.07.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ActivityTypeButton: View {
    
    @ObservedObject var searchData: SearchData
    
    let eventType: ActivityType
    let imageString: String
    let buttonTextString: String
    
    @Binding var selectedEventType: ActivityType?
    @Binding var tmpValues: TemporaryGroupValues
    
    func setSelectedEventType(activityType: ActivityType) {
        if selectedEventType != activityType {
            selectedEventType = activityType
        } else {
            selectedEventType = nil
        }
        
    }
    
    func isEventTypeAvailable(eventType: ActivityType) -> Bool {
        // TODO
        if !searchData.eventTypes.contains(eventType){
                return false
        }
        
        for profile in tmpValues.groupList {
            if !profile.searchTypes.contains(eventType) {
                return false
            }
        }
        
        return true
    }
    
    var body: some View {
            
            Button(action: {
                withAnimation(.linear(duration: 0.2)) {
                    self.setSelectedEventType(activityType: self.eventType)
                }
            }) {
                VStack(alignment: .center){
                    
                    Image(systemName: imageString)
                        .font(.system(size: 25, weight: .medium))
                        .foregroundColor(selectedEventType == eventType ? .white : Color ("button1"))
                        .fixedSize()
                        .frame(width: 50, height: 50)
                        .background(selectedEventType == eventType ? gradientCherryPink : gradientGray)
                        .clipShape(Circle())
                        .shadow(radius: 4, y: 2)

                    Text(buttonTextString)
                        .font(.avenirNextRegular(size: 12))
                        .fontWeight(.semibold)
                        .frame(width: 118)
                        .lineLimit(2)
                }
            }.animation(nil)
            .foregroundColor(Color ("button1"))
                .disabled(!isEventTypeAvailable(eventType: eventType))
//                .saturation(selectedEventType == eventType ? 1.0 : 0.0)
                .buttonStyle(BorderlessButtonStyle())
    }
}

//struct ActivityTypeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityTypeButton()
//    }
//}
