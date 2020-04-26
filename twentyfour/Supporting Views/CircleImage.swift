//
//  CircleImage.swift
//  twentyfour
//
//  Created by Sebastian Fox on 13.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {

        GeometryReader { geometry in
            self.image
            .resizable()
            .scaledToFill()
            .frame(
                width: min(geometry.size.width, geometry.size.height),
                height: min(geometry.size.width, geometry.size.height))
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))

//            .rotationEffect(.degrees(90))
//                self.image.shadow(radius: 5)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
