//
//  ScannerView.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/13/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    @State var isShowingScanner = false
    @State var QRType : CONSTANT.QRType = .QR_CI
    @State var countOfClients : Int
    @Binding var showInfoScanned :Bool
    @Binding var info : Prospect
    var body: some View {
        VStack{
            CodeScannerView(codeTypes: [.qr], simulatedData: "N:WILDER\rAA:LOPEZ ELIAS\rCI:95061249224\rFV:ABA585784\r", completion: self.handleScan)
        Spacer()
            Image(systemName: "keyboard").font(.system(size: 40)).padding(.bottom, 50)
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
                  self.isShowingScanner = false
                  // more code to come
                   switch result {
                   case .success(let code):
                       let details = code.components(separatedBy: "\r")
           //            guard details.count == 2 else {
           //                print("\(details.count) Datos raros: \(code)")
           //                return }
                       print(code)
                      let person = Prospect()
                       switch details.count {
                       case 2:
                           person.name = details[0]
                           person.data = details[1]
                           self.QRType = CONSTANT.QRType.QR_NAME_EMAIL
                           
                       case 5:
                           let xName = details[0].components(separatedBy: ":")
       //
                           let xLName = details[1].components(separatedBy: ":")
                           let xCi = details[2].components(separatedBy: ":")
                           print(xName)
                           
                           print("xn: \(xName) xLn: \(xLName)")
           //                  person.name = "\(details[0]) \(details[1])"
                           person.name = "\(xName[1]) \(xLName[1])"
                           person.data = "\(xCi[1])"
                           UIDevice.playSound(soundID: 1111)
       //                    Notify.me()
                           //1009
                           self.countOfClients += 1
                           self.QRType = CONSTANT.QRType.QR_CI
                           
                       default:
                           print("details count :\(details.count)")
                           self.QRType = CONSTANT.QRType.QR_ANY
                           UIDevice.playSound(soundID: 1112)
                           //1073, accept 1111, cancel 1112
                       }

                       self.info = person
                       
                       self.showInfoScanned = true
                   case .failure(let error):
                       print("Scanning failed \(error)")
                   }
               }
    
}

struct ScannerView_Previews: PreviewProvider {
    @State static var countOfClients = 0
    @State static var showInfoScanned = false
    @State static var info = Prospect()
    static var previews: some View {
        ScannerView(countOfClients: countOfClients, showInfoScanned: $showInfoScanned, info: $info)
    }
}
