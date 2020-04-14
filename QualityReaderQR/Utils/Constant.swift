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
    
    enum QueueUpdateAction: String {
        case ADD_CLIENT = "ADD_CLIENT"
        case FINISH = "FINISH"
    }
    enum ClientUpdateAction : String{
        case ADD_DENEGATECOUNT = "ADD_DENEGATECOUNT"
        case UPDATE_ALL = "UPDATE_ALL"
    }
    
    enum QueueType : String{
        case DIRECT_Q = "DIRECT_Q"
        case VERIFY_Q = "VERIFY_Q"
    }
    static func isOpenQueue() -> Bool{
        if (UserDefaults.standard.value(forKey: "Did_Finish_Queue") != nil) {
            return true
        }
        return false
    }
    static func saveQueueState(isOpenQueue: Bool){
        UserDefaults.standard.set(isOpenQueue, forKey: "Did_Finish_Queue")
    }
}
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    static func playSound(soundID: SystemSoundID){
        AudioServicesPlaySystemSound(soundID)
    }
}
