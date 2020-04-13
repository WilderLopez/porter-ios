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
    
    var body: some View {
        
        ScrollView{
            if self.queues.count > 0{
            ForEach(0..<queues.count){ row in

                VStack(spacing: 10){
                    NavigationLink(destination: QueueView(queue: self.queues[row])){
                        QueueViewCell(name: "\(self.queues[row].name)", beginDate: "\(self.queues[row].dateBegin)", endDate: "\(self.queues[row].dateEnd)", clients: Int(self.queues[row].clients.count), denegateClients: Int(self.queues[row].denegateClients))
                    }
                }
                .padding(.vertical, 10)
                
                
        }.padding(.top, 20)
        }
        }
        .onAppear(perform: {
            self.queues = QueueManager.getAllQueue()
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
