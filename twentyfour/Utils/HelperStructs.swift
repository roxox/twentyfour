//
//  HelperStructs.swift
//  twentyfour
//
//  Created by Sebastian Fox on 16.04.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI

// MARK: - Implementation
//@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
//private struct _CustomForeground<Content: View, Overlay: View>: View {
//    let content: Content
//    let overlay: Overlay
//
//    internal init(overlay: Overlay, for content: Content ) {
//        self.content = content
//        self.overlay = overlay
//    }
//
//    var body: some View {
//        content.overlay(overlay).mask(content)
//    }
//}

//struct MyShape : Shape {
//    func path(in rect: CGRect) -> Path {
//        var p = Path()
//
//        p.addArc(center: CGPoint(x: 100, y:100), radius: 50, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: true)
//
//        return p.strokedPath(.init(lineWidth: 3, dash: [5, 3], dashPhase: 10))
//    }
//}

//struct CustomTextField: UIViewRepresentable {
//
//    class Coordinator: NSObject, UITextFieldDelegate {
//
//        @Binding var text: String
//        var didBecomeFirstResponder = false
//
//        init(text: Binding<String>) {
//            _text = text
//        }
//
//        func textFieldDidChangeSelection(_ textField: UITextField) {
//            text = textField.text ?? ""
//        }
//
//    }
//
//    @Binding var text: String
//    var isFirstResponder: Bool = false
//
//    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
//        let textField = UITextField(frame: .zero)
//        textField.delegate = context.coordinator
//        return textField
//    }
//
//    func makeCoordinator() -> CustomTextField.Coordinator {
//        return Coordinator(text: $text)
//    }
//
//    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomTextField>) {
//        uiView.text = text
//        if isFirstResponder && !context.coordinator.didBecomeFirstResponder  {
//            uiView.becomeFirstResponder()
//            context.coordinator.didBecomeFirstResponder = true
//        }
//    }
//}


struct BlurView: UIViewRepresentable {
    typealias UIViewType = UIView
    var style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
    }
}

enum PageIndex: Int {
    case main = 0
    case calc = 1
}
