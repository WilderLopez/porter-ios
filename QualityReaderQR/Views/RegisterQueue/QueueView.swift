//
//  QueueView.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/12/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI

struct QueueView: View {
    @State var queueID : String
    @State var clients = [Client]()
    
    var body: some View {
        VStack{
            ScrollView{
                if self.clients.count > 0{
                ForEach(0..<self.clients.count){ row in
                    VStack(spacing: 10){
                    ClientViewCell(name: "\(self.clients[row].name)", ci: "\(self.clients[row].ci)", denegateCount: Int( self.clients[row].denegateCount))
                    }.padding(.vertical, 10)
                }.padding(.top, 20)
            }
            }
            .onAppear {
                self.clients = ClientsManager.getAllClients(queueID: self.queueID)
            }
        }
    .navigationBarTitle(Text("Todos"))
    }
}

struct QueueView_Previews: PreviewProvider {
    @State static var queueID = "sad"
    static var previews: some View {
        QueueView(queueID: queueID)
    }
}
