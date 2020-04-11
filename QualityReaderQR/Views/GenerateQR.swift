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
            VStack {
                
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)

                TextField("Any data", text: $data)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])

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
            self.showModalGenerateQR = true
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
