//
//  Extensions.swift
//  twentyfour
//
//  Created by Sebastian Fox on 16.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

// MARK: - API
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    public func foreground<Overlay: View>(_ overlay: Overlay) -> some View {
        self.overlay(overlay).mask(self)
    }
}
extension Font {
    static func avenirNext(size: Int) -> Font {
        return Font.custom("Avenir Next", size: CGFloat(size))
    }
    
    static func avenirNextRegular(size: Int) -> Font {
        return Font.custom("AvenirNext-Regular", size: CGFloat(size))
    }
}
