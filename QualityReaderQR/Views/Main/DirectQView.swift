//
//  DirectQView.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/13/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI
import CodeScanner

struct DirectQView: View {
    

   
    @Binding var dateString : String
    @Binding var timeString : String
    @Binding var countOfClients : Int
    @Binding var showInfoScanned : Bool
    @Binding var info : Prospect
    @Binding var QRType : CONSTANT.QRType
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){

                        VStack{
                            Text("\(dateString)").font(.system(.subheadline, design: .rounded)).bold()
                            Text("Hora de inicio: \(timeString)").font(.system(.subheadline, design: .rounded))
                        }.padding(.top)
                        VStack{
                            Text("\(countOfClients)").font(.system(size: 200, weight: .bold, design: .rounded)).foregroundColor(Color.purple)
                            Text("Total de clientes").font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    if showInfoScanned{
                        withAnimation {
                        HeaderView(name: $info.name, data: $info.data, typeQR: $QRType)
                        }
                    }

                                        
//                    NavigationLink(destination: NewInfo()){
//                            Image(systemName: "keyboard").font(.system(size: 40)).padding(.bottom, 50)
//                    }
                            
                }
    }
    
   
}

struct DirectQView_Previews: PreviewProvider {
    @State static var dateString = ""
    @State static var timeString = ""
    @State static var countOfClients = 0
    @State static var showInfoScanned = false
    @State static var info : Prospect = Prospect()
    @State static var QRType : CONSTANT.QRType = .QR_CI
    
    static var previews: some View {
        DirectQView(dateString: $dateString, timeString: $timeString, countOfClients: $countOfClients, showInfoScanned: $showInfoScanned, info: $info, QRType: $QRType)
    }
}
