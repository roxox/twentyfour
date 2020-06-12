//
//  LabelTextStore.swift
//  twentyfour
//
//  Created by Sebastian Fox on 05.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import SwiftUI
import Combine

class LabelTextStore: ObservableObject {
    @Published var lblTxts: [LabelText] = labelTexts
    
    func getTxt(id: String) -> String {
        var msg = "label not found"
        let langStr = Locale.current.languageCode
        
        let foundLblTxt = lblTxts.filter { $0.identifier == id }
        if foundLblTxt.count != 0 {
            if langStr == "en" {
                msg = foundLblTxt.first!.german!
            } else {
                msg = foundLblTxt.first!.english!
            }
        }
        return msg
    }
}
