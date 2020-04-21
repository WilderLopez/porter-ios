//
//  HelperClasses.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/21/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import Foundation
import SwiftUI

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    init(limit: Int) {
        characterLimit = limit
    }
    var characterLimit : Int
}
