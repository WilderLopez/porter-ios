//
//  Models.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/10/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

struct CONSTANT{
    enum QRType : String {
        case QR_CI = "QR_CI"
//        case QR_SOLAPIN = "QR_SOLAPIN" // not supported
        case QR_NAME_EMAIL = "QR_NAME_EMAIL"
        case QR_ANY = "QR_ANY"
    }
}
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    static func playSound(){
        AudioServicesPlaySystemSound(1003)
    }
}
