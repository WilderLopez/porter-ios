//
//  NewInfo.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/10/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI

struct NewInfo: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var ci = TextBindingManager(limit: 11)
    
    @Binding var Name : String
    @Binding var Ci : String
    @Binding var showInfoScanned : Bool
    
    var body: some View {
        ScrollView{
            Text("Introduzca sus datos").font(.system(.largeTitle, design: .rounded)).bold().padding(.top, 10)
        VStack(spacing: 10){
            
        VStack (spacing: 15){
                        VStack{
                        Text("*Nombre y Apellidos")
                            .font(.system(size: 11))
                            .foregroundColor(.red)
                            .multilineTextAlignment(.leading)
                        
                        TextField("Nombre", text: $Name)
                            .textContentType(.name)
                            .font(.system(.title, design: .rounded))
                            .keyboardType(.alphabet)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding( .bottom)
                            
                    }
                        VStack{

                        Text("*Carnet de Identidad")
                            .font(.system(size: 11))
                            .foregroundColor(.red)
                            .multilineTextAlignment(.leading)

                            TextField("CI", text: $ci.text)
                            .textContentType(.emailAddress)
                            .font(.system(.title, design: .rounded))
                            .padding(.bottom)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }.padding(.vertical, 40)
            
            
            Button(action: {
                
                self.showInfoScanned = true
                self.Ci = self.ci.text
                
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("VERIFICAR").font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 34)
                    .background(Color.MyPrimaryColor)
                    .cornerRadius(15)
                
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .frame(height: 40)
            .disabled( (self.ci.text.count != 11 || self.Name.isEmpty) )
            .opacity((self.ci.text.count != 11  || self.Name.isEmpty) ? 0.3 : 1)
            Spacer()
            
        }.padding(.horizontal, 30)
        }.onAppear(perform: {
            print("OnAppear showInfoScanned :\(self.showInfoScanned)")
            self.showInfoScanned = false
        })
            
//        .navigationBarTitle(Text("Introduzca sus datos"), displayMode: .inline)
        .modifier(DismissingKeyboard())
    }
}

struct NewInfo_Previews: PreviewProvider {
    @State static var Name = "Wilder"
    @State static var Ci = "953423"
    @State static var showInfoScanned = true
    static var previews: some View {
        NewInfo(Name: $Name, Ci: $Ci, showInfoScanned: $showInfoScanned)
    }
}
