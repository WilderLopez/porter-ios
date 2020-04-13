//
//  GenerateQR.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/10/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import PartialSheet

struct GenerateQR: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    @State var name : String = ""
    @State var data : String = ""
    
    @State var showModalGenerateQR = false
    
    var body: some View {
       
        ScrollView{
            VStack (spacing: 15){
                VStack{
//                HStack{
                Text("*Nombre y Apellidos").font(.system(size: 11))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
//                    .padding(.leading, 100)
//                    Spacer()
//                    }
                
                TextField("Nombre", text: $name)
                    .textContentType(.name)
                    .font(.system(.title, design: .rounded))
                    .textContentType(.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.horizontal, .bottom])
                    
                
            }
                VStack{
//                HStack{
                Text("*Carnet de Identidad").font(.system(size: 11))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
//                    .padding(.leading, 100)
//                    Spacer()
//                    }
                TextField("CI", text: $data)
                    .textContentType(.emailAddress)
                    .font(.system(.title, design: .rounded))
                    .padding([.horizontal, .bottom])
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .disabled(data.count > 11 )
                }
            }.padding(.vertical, 40)
               
            
            }
            .partialSheet(presented: $showModalGenerateQR) {
                
                VStack(alignment: .center, spacing: 10){
                                   Text("Your info in QR").font(.system(.headline, design: .rounded))
                                   
                                   Image(uiImage: self.generateQRCode(from: "\(self.name)\r\(self.data)"))
                                   .interpolation(.none)
                                   .resizable()
                                   .scaledToFit()
                                   .frame(width: 200, height: 200)
                }
                       }
        .navigationBarTitle("Personal info")
    .navigationBarItems(trailing:
        Button(action: {
            DismissingKeyboard.dismissKeyBoard()
            self.showModalGenerateQR = true
            UIDevice.playSound(soundID: 1394)
            //1394 sing-in sound and vibration
        }){
            Text("Create QR")}
            )
        .modifier(DismissingKeyboard())
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct GenerateQR_Previews: PreviewProvider {
    static var previews: some View {
        GenerateQR()
    }
}
