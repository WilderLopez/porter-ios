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
import SwiftUI

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
        if let x = UserDefaults.standard.value(forKey: "Did_Finish_Queue") as? Bool{
            return x
        }
        return false
    }
    static func getLastQueueID() -> String?{
        return UserDefaults.standard.value(forKey: "Last_QueueID") as? String
    }
    static func saveQueueState(isOpenQueue: Bool, queueID: String? = nil){
        UserDefaults.standard.set(isOpenQueue, forKey: "Did_Finish_Queue")
        if queueID != nil  && isOpenQueue{
        UserDefaults.standard.set(queueID, forKey: "Last_QueueID")
        }
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

extension Color {
    
    static let MyPrimaryColor = Color("MyColor")
}
