//
//  QueueView.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/12/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI

struct QueueView: View {
    @State var queue : Queue
    
    var body: some View {
        VStack{
            ScrollView{

                ForEach(0..<self.queue.clients.count){ row in
                    VStack(spacing: 10){
                    ClientViewCell(name: "\(self.queue.clients[row].name)", ci: "\(self.queue.clients[row].ci)", denegateCount: Int( self.queue.clients[row].denegateCount))
                    }.padding(.vertical, 10)
                }.padding(.top, 20)
            }
        }
    .navigationBarTitle(Text("Todos"))
    }
}

struct QueueView_Previews: PreviewProvider {
    @State static var queue = Queue()
    static var previews: some View {
        QueueView(queue: queue)
    }
}
