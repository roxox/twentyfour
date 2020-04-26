
//  HomeAppUserRow.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct ActivityDescriptionView: View {
    var body: some View {
        VStack(alignment: .leading) {

            Text("Das steckt hinter den Symbolen in der Aktivitäten in dieser App.")
            .font(.avenirNextRegular(size: 16))
                .fontWeight(.bold)
                .padding([.leading, .trailing], 20)
                .foreground(Color ("DarkGray"))
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(4)
                    
//                Necessary to get the whole width backgroundcolor
            HStack() {
                Spacer()
            }
        }
        .padding(.vertical, 25)
        .padding(.bottom, 60)
    }
}

struct FeaturedGroupRowItem: View {
    var items: [AppUser]
    var appUser: AppUser
    var body: some View {
        HStack(){
            ForEach(self.items) { user in
                user.image
                    .resizable()
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .frame(width: CGFloat(320/self.items.count), height: 240.0)
                    .padding(0)
            }
        }
        .cornerRadius(8)
        .padding(.leading, 15)
    }
}

struct ActivityDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
            ActivityDescriptionView()
//            .environmentObject(UserData())
        }
}
