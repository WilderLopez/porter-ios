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
    @State var queueName: String
    @State var clients = [Client]()
    
//    @discardableResult
//    func share(
//        items: [Any],
//        excludedActivityTypes: [UIActivity.ActivityType]? = nil
//    ) -> Bool {
//        guard let source = UIApplication.shared.windows.last?.rootViewController else {
//            return false
//        }
//        let vc = UIActivityViewController(
//            activityItems: items,
//            applicationActivities: nil
//        )
//        vc.excludedActivityTypes = excludedActivityTypes
//        vc.popoverPresentationController?.sourceView = source.view
////        vc.modalPresentationStyle = .pageSheet
////        vc.presentationController?.presentedViewController.view = source.view
//        source.present(vc, animated: true)
//        return true
//    }
    
    @State var shareSheetPresent = false
    
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
                self.clients = ClientsManager.getAllClients(queueID: self.queueID).reversed()
            }
        }
    .navigationBarTitle(Text("Todos"))
    .navigationBarItems(trailing:
        Button(action: {
            print("share tapped")
//            Exporting.goOn()
            self.shareSheetPresent = true
//            self.share(items: [Exporting.goOn()])
        }){
            Image(systemName: "square.and.arrow.up").font(.system(size: 25)).accentColor(.MyPrimaryColor)
        }
        )
            .sheet(isPresented: $shareSheetPresent, onDismiss: {
                self.shareSheetPresent = false
                print("its false")
            }) {
                ShareSheet(activityItems: [Exporting.toCSV(clients: self.clients, filename: self.queueName)]).onDisappear {
                    print("Hey this disappear!")
                    self.shareSheetPresent = false
                }
        }

    }
}

//struct QueueView_Previews: PreviewProvider {
//    @State static var queueID = "sad"
//    static var previews: some View {
//        QueueView(queueID: queueID)
//    }
//}
