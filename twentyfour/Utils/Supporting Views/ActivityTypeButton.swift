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
                    Spacer()
                    Image(systemName: imageString)
                        .font(.system(size: 25 * 0.8, weight: selectedEventType == eventType ? .semibold : .medium))
//                        .foregroundColor(selectedEventType == eventType ? .white : Color ("button1"))
//                        .foregroundColor(Color ("button1"))
                        //                                    .foregroundColor(Color ("Darknight"))
                        .foreground(selectedEventType == eventType ? gradientCherryPink : gradientAlmostBlack)
//                        .foregroundColor(selectedEventType == eventType ? Color ("Darknight2") : Color ("button1"))
                        .fixedSize()

                    Text(buttonTextString)
                        .font(.avenirNextRegular(size: 10))
                        .fontWeight(selectedEventType == eventType ? .semibold : .medium)
//                        .foregroundColor(selectedEventType == eventType ? .white : Color ("button1"))
//                        .foregroundColor(Color ("button1"))
                        .foreground(selectedEventType == eventType ? gradientCherryPink : gradientAlmostBlack)
//                        .foregroundColor(selectedEventType == eventType ? Color ("Darknight2") : Color ("button1"))
//                        .frame(width: 118)
                        .lineLimit(2)
//                        .padding(.bottom, 5)
                    Spacer()
                }
                .frame(width: ((UIScreen.main.bounds.width - 90) / 3) * 0.8, height: 80 * 0.8)
//                .background(selectedEventType == eventType ? gradientCherryPink : gradientWhite)
//                .background(selectedEventType == eventType ? gradientGray : gradientWhite)
                .background(Color .white)
//                        .clipShape(Circle())
                .clipShape(RoundedRectangle(cornerRadius: 8))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color ("Gray"), lineWidth: 0.5)
//                )
                .shadow(radius: 2, y: 1)
            }
        
            .animation(nil)
            .foregroundColor(Color ("button1"))
//                .disabled(!isEventTypeAvailable(eventType: eventType))
//                .saturation(selectedEventType == eventType ? 1.0 : 0.0)
                .buttonStyle(BorderlessButtonStyle())
            .padding(.horizontal, 2)
    }
}

//struct ActivityTypeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityTypeButton()
//    }
//}
