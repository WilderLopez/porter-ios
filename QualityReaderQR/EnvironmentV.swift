//
//  EnvironmentV.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/10/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import Foundation
import SwiftUI


final class UserData : ObservableObject{
    @Published var isNavBarHidden = true
}

class Prospect{
    var name : String
    var data : String
    
    init() {
        name = ""
        data = ""
    }
    
    init(name: String, data : String) {
        self.name = name
        self.data = data
    }
}
