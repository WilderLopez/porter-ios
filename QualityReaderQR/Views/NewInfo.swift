//
//  NewInfo.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/10/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI

struct NewInfo: View {
    
    @State var name : String = ""
    @State var ci : String = ""
    var body: some View {
        ScrollView{
        VStack(spacing: 10){
            
        VStack (spacing: 15){
                        VStack{
        //                HStack{
//                            if self.name.isEmpty{
//                                withAnimation{
                                Text("*Nombre y Apellidos")
                                    .font(.system(size: 11))
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.leading)
//                                }
//                            }
                        
                        TextField("Nombre", text: $name)
                            .textContentType(.name)
                            .font(.system(.title, design: .rounded))
                            .textContentType(.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding( .bottom)
                            
                        
                    }
                        VStack{
        //                HStack{
//                            if self.ci.isEmpty{
//                                withAnimation {
                                Text("*Carnet de Identidad")
                                    .font(.system(size: 11))
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.leading)
//                                }
//                            }
                        TextField("CI", text: $ci)
                            .textContentType(.emailAddress)
                            .font(.system(.title, design: .rounded))
                            .padding(.bottom)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
        //                    .disabled(data.count > 11 )
                        }
                    }.padding(.vertical, 40)
            
            
            Button(action: {
                
            }){
                Text("VERIFICAR").font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 34)
                    .background(Color.purple)
                    .cornerRadius(15)
                
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: 40)
            .disabled( (self.ci.count != 11 || self.name.isEmpty) )
                .opacity((self.ci.count != 11  || self.name.isEmpty) ? 0.3 : 1)
            Spacer()
            
        }.padding(.horizontal, 30)
        }
            
        .navigationBarTitle(Text("Introdusca sus datos"), displayMode: .inline)
        .modifier(DismissingKeyboard())
    }
}

struct NewInfo_Previews: PreviewProvider {
    static var previews: some View {
        NewInfo()
    }
}
