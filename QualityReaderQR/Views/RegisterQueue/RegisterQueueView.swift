//
//  RegisterQueueView.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/12/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI

struct RegisterQueueView: View {
    
    @State var queues: [Queue] = [Queue]()
    @State var countOfClients = 0
    var body: some View {
        
        ScrollView{
            if self.queues.count > 0{
                ForEach(0..<queues.count){ row in

                VStack(spacing: 10){
                    if ClientsManager.getAllClients(queueID: self.queues[row].id).count > 0 {
                        NavigationLink(destination: QueueView(queueID: "\(self.queues[row].id)")){
                            QueueViewCell(name: "\(self.queues[row].name)", beginDate: "\(self.queues[row].dateBegin)", endDate: "\(self.queues[row].dateEnd)", clients: ClientsManager.getAllClients(queueID: self.queues[row].id).count, denegateClients: Int(self.queues[row].denegateClients)).accentColor(.black)
                        }
                    }
                    else {
                        QueueViewCell(name: "\(self.queues[row].name)", beginDate: "\(self.queues[row].dateBegin)", endDate: "\(self.queues[row].dateEnd)", clients: 0, denegateClients: Int(self.queues[row].denegateClients))
                    }
                }
//                .onAppear(perform: {
//                    self.countOfClients = ClientsManager.getAllClients(queueID: self.queues[row].id).count
//                    print("allClients :\(self.countOfClients)")
//                })
                .padding(.vertical, 10)
                
                
        }.padding(.top, 20)
        }
        }
        .onAppear(perform: {
            self.queues = QueueManager.getAllQueue().reversed()
        })
    .navigationBarTitle("Registro de colas")
        
        
    }
}

struct RegisterQueueView_Previews: PreviewProvider {
//    @State static var queues = [Queue]()
    static var previews: some View {
        RegisterQueueView()
    }
}
