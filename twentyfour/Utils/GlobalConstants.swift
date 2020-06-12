//
//  GlobalConstants.swift
//  twentyfour
//
//  Created by Sebastian Fox on 05.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation
import SwiftUI
    
var gradientSeaAndBlue: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
            [
                Color ("Sea"),
                .blue,
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}

var gradientPinkPinkAndPeach: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
            [
                .pink,
                .pink,
                Color ("Peach")
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}
    
var gradientWhite: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
            [
                Color .white,
                Color .white,
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}
    
var gradientGray: LinearGradient {
    LinearGradient(
        gradient: Gradient(
            colors:
            [
            Color ("SuperLightGray"),
            Color ("SuperLightGray"),
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing)
}
