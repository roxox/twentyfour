//
//  LabelText.swift
//  twentyfour
//
//  Created by Sebastian Fox on 05.06.20.
//  Copyright © 2020 Sebastian Fox. All rights reserved.
//

import Foundation

struct LabelText {
    var identifier: String?
    var german: String?
    var english: String?
    
    init (identifier: String, german: String, english: String) {
        self.identifier = identifier
        self.german = german
        self.english = english
    }
}

var labelTexts = [
LabelText(identifier: "versionHistory", german: "Version", english: "Version"),
LabelText(identifier: "licences", german: "Lizenzen", english: "Licences"),
]
