//
//  UserDetailsView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 19.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct UserDetailsView: View {
    let user: Profile
    
    var body: some View {
        VStack() {
            ScrollView() {
                VStack() {
                    Text(user.username)
                    Text(user.email)
                    Text(user.searchParameter.locationName)
                }
            }
        }
    }
}

//struct UserDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailsView()
//    }
//}
