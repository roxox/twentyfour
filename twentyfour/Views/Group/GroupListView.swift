//
//  GroupListView.swift
//  twentyfour
//
//  Created by Sebastian Fox on 22.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct GroupListView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack() {
            Text("Gruppen")
            ScrollView(){
                ForEach(userData.groupList) { group in
                    Text(group.title!)
                }
            }
        }
    }
}

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView()
    }
}
