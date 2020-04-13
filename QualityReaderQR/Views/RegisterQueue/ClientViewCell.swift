//
//  ClientViewCell.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/13/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI

struct ClientViewCell: View {
    
    @State var name: String
    @State var ci: String
    @State var denegateCount: Int
    
    var body: some View {
        HStack{
        VStack(alignment: .leading,spacing: 10){
            Text(self.name).font(.system(size: 25, weight: .bold, design: .rounded))
            .multilineTextAlignment(.leading)
            
            Text("CI: \(self.ci)").font(.system(size: 17, design: .rounded))
            
            Text("Veces denegado:  \(self.denegateCount)").font(.system(size: 17, design: .rounded)).foregroundColor(.red)
           
        }
        .padding()
        .frame(minWidth: 0,maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        }.padding(.horizontal, 20)
    }
}

struct ClientViewCell_Previews: PreviewProvider {
    @State static var name = "WILDER LOPEZ ELIAS"
    @State static var ci = "95061249224"
    @State static var denegateCount = 2
    
    static var previews: some View {
        ClientViewCell(name: name, ci: ci, denegateCount: denegateCount)
    }
}
