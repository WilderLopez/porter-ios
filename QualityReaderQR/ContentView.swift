//
//  ContentView.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/10/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI
import CodeScanner

//struct Prospect {
//    var
//}

struct ContentView: View {
   
    @State var isShowingScanner = false
    @State var showInfoScanned = false
    @EnvironmentObject var userData: UserData
    @State var info : Prospect = Prospect()
    @State var QRType : CONSTANT.QRType = .QR_CI
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 30){
                Spacer()
                
                if showInfoScanned{
                    withAnimation {
                    HeaderView(name: $info.name, data: $info.data, typeQR: $QRType).padding(.bottom, 100)
                    }
                }
            Button(action: {
                self.isShowingScanner = true
            }){
                VStack(spacing: 20){
                Image(systemName: "qrcode.viewfinder").font(.system(size: 100))
                Text("Scanner")
                }
            }
                Spacer()
                    
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "N:WILDER%20%0D%0AA:LOPEZ%20ELIAS%0D%0ACI:95061249224%0D%0AFV:ABA585784", completion: self.handleScan)
            }

        }
        .navigationBarTitle(Text("Quality Reader").font(.system(.largeTitle, design: .rounded)).fontWeight(.bold))
                
        .navigationBarItems(trailing:
                NavigationLink(destination: GenerateQR()){
                Image(systemName: "qrcode")
                    .font(.system(size: 30))
            }
            )

        }.accentColor(Color.purple)
        
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
                    self.QRType = CONSTANT.QRType.QR_CI
                    
                default:
                    print("details count :\(details.count)")
                    self.QRType = CONSTANT.QRType.QR_ANY
                }

                
    //            person.name = details[0]
    //            person.data = details[1]
    //            print("name: \(person.name) and data: \(person.data)")
                self.info = person
                UIDevice.playSound()
                self.showInfoScanned = true
            case .failure(let error):
                print("Scanning failed \(error)")
            }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}



struct HeaderView: View {
    
   @Binding var name : String
   @Binding var data : String
   @Binding var typeQR: CONSTANT.QRType
    
    var body: some View {
        VStack{
            Text("Name: \(name)").font(.system(.headline, design: .rounded)).fontWeight(.bold)
            Text("\(typeQR == CONSTANT.QRType.QR_NAME_EMAIL ? "Data" : "CI" ): \(data)").font(.system(.headline, design: .rounded)).fontWeight(.bold)
        }.padding()
    }
}
