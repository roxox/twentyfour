//
//  AppUserImage.swift
//  twentyfour
//
//  Created by Sebastian Fox on 14.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

struct AppUserImage: View {
    var image: Image
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AppUserImage_Previews: PreviewProvider {
        static var previews: some View {
            AppUserImage(image: Image("turtlerock"))
        }
    }
