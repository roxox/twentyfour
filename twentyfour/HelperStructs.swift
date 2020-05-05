//
//  HelperStructs.swift
//  twentyfour
//
//  Created by Sebastian Fox on 16.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

// MARK: - Implementation
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
private struct _CustomForeground<Content: View, Overlay: View>: View {
    let content: Content
    let overlay: Overlay

    internal init(overlay: Overlay, for content: Content ) {
        self.content = content
        self.overlay = overlay
    }

    var body: some View {
        content.overlay(overlay).mask(content)
    }
}

struct MyShape : Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()

        p.addArc(center: CGPoint(x: 100, y:100), radius: 50, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: true)

        return p.strokedPath(.init(lineWidth: 3, dash: [5, 3], dashPhase: 10))
    }
}
