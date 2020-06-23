//
//  HelperFunctions.swift
//  twentyfour
//
//  Created by Sebastian Fox on 05.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import SwiftUI


func makeGradient(colors: [Color]) -> some View {
    LinearGradient(
        gradient: .init(colors: colors),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
