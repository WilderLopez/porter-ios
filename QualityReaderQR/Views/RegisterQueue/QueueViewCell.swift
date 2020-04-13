//
//  QueueView.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/12/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI

struct QueueViewCell: View {
    @State var name : String
    
    @State var beginDate : String
    @State var endDate : String
    @State var clients : Int
    @State var denegateClients : Int
    
    var body: some View {
        HStack{
        VStack(alignment: .center,spacing: 10){
            Text(self.name).font(.system(size: 25, weight: .bold, design: .rounded))
            .multilineTextAlignment(.leading)
            HStack{
            Text("Inicio: \(self.beginDate)").font(.system(size: 17, design: .rounded))
            Text("Fin: \(self.endDate)").font(.system(size: 17, design: .rounded))
            }
            HStack{
                Text("Clientes: \(self.clients)").font(.system(size: 17, design: .rounded))
                Text("Denegados: \(self.denegateClients)").font(.system(size: 17, design: .rounded)).foregroundColor(.red)
            }
        }
        .padding()
        .frame(minWidth: 0,maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        }.padding(.horizontal, 20)
//        .frame(minWidth: 0,maxWidth: .infinity)
    }
}

struct QueueViewCell_Previews: PreviewProvider {
    @State static var name = "12 de abril de 2020"
    @State static var beginD = "11:31 AM"
    @State static var endD = "2:22 PM"
    @State static var clients = 12
    @State static var den = 3
    static var previews: some View {
        QueueViewCell(name: name, beginDate: beginD, endDate: endD, clients: clients, denegateClients: den)
    }
}
