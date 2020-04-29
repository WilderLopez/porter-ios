//
//  ContentView.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/10/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

//struct Prospect {
//    var
//}

struct ContentView: View {
   
    @State var isShowingScanner = false
    @State var showInfoScanned = false
    @State var showAlet = false
    @EnvironmentObject var userData: UserData
    @State var info : Prospect = Prospect()
    @State var QRType : CONSTANT.QRType = .QR_CI
    @State var dateString = ""
    @State var timeString = ""
    @State var CurrentQueue : Queue = Queue()
    @State var countOfClients = 0
    @State var queueType : CONSTANT.QueueType?
    @State var isStarted = false
    @State var isDenegate = false
    @State var isKeyboardView = false
    
    @State var newName = ""
    @State var newCi = ""
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                if isStarted{
                    
                    VStack{
                        
                        withAnimation {
                            DirectQView(dateString: $dateString, timeString: $timeString, countOfClients: $countOfClients, showInfoScanned: $showInfoScanned, info: $info, QRType: $QRType, isDenegate: $isDenegate)
                        }
                        
                        Spacer()
                        HStack(alignment: .center, spacing: 50){
                        
                        Button(action: {
                            self.isShowingScanner = true
                            self.showInfoScanned = false
                        }){
                            VStack(spacing: 20){
                            Image(systemName: "qrcode.viewfinder").font(.system(size: 60))

                            }
                        }.padding([.bottom, .top], 50)
                        //MARK: IT's OK METHOD
                        .sheet(isPresented: $isShowingScanner, onDismiss: {
                            if self.showInfoScanned {
                                self.itsOK()
                                        }
                                    }) {
                                        //MARK: SCANNERVIEW
                                        
                                        CodeScannerView(codeTypes: [.qr], simulatedData: "N:WILDER\rAA:LOPEZ ELIAS\rCI:95061249224\rFV:ABA585784\r", completion: self.handleScan)
                                    }
                            
//                            NavigationLink(destination: ScannerView(countOfClients: countOfClients, showInfoScanned: $showInfoScanned, info: $info)){
//
//                                Image(systemName: "qrcode.viewfinder").font(.system(size: 60))
//                            }.padding([.bottom, .top], 50)
                       
                            //MARK: Buttons Bottom
                            
                            Button(action: {
                                self.info.name = ""
                                self.info.data = ""
                                self.isKeyboardView = true
                            }){
                                Image(systemName: "keyboard").font(.system(size: 40))
                            }
                            //MARK: Go to NewInfo
                                .sheet(isPresented: $isKeyboardView, onDismiss: {
                                    print("new name: \(self.info.name)")
                                    print("new ci: \(self.info.data)")
                                    if self.showInfoScanned{
                                    self.itsOK()
                                    }
                                }) {
                                    NewInfo(Name: self.$info.name, Ci: self.$info.data, showInfoScanned: self.$showInfoScanned)
                            }
                            if queueType == CONSTANT.QueueType.VERIFY_Q{
                            Button(action: {
                                
                            }){
                                Image(systemName: "doc.text.viewfinder").font(.system(size: 60))
                            }
                            }
                        }
                        .alert(isPresented: $showAlet, content: {Alert(title: Text("Cola"), message: Text("¿Desea terminar la cola?"),  primaryButton: .default(Text("No")), secondaryButton: .destructive(Text("Si"), action: {
                            
                            
                            CONSTANT.saveQueueState(isOpenQueue: false)
                            if QueueManager.updateQueue(queueId: self.CurrentQueue.id, queueAction: CONSTANT.QueueUpdateAction.FINISH){
                                
                                self.countOfClients = 0
                                self.isStarted = false
                                self.showInfoScanned = false
                                print("Queue FINISHED OK 😎")
                            }else {
                                print("ERROR FINISHING QUEUE")
                            }
                        }))})
                        
                        
                    }
                }
                else {
                    //MARK:  STARTER BUTTOM
                    HStack(alignment: .center, spacing: 50){
                    Button(action: {
                        self.queueType = CONSTANT.QueueType.DIRECT_Q
                        self.isStarted = true
                        let date = Date()
                        let formatter1 = DateFormatter()
                        let formatter2 = DateFormatter()
                        
                        formatter1.dateStyle = .long
                        formatter2.timeStyle = .short
                        
                        formatter1.locale = .init(identifier: "es_ES")
                        self.dateString = formatter1.string(from: date)
                        self.timeString = formatter2.string(from: date)
                        
                        //Create Queue
                        
                        self.CurrentQueue = Queue()
                        self.CurrentQueue.id = UUID().uuidString
                        self.CurrentQueue.name = self.dateString
                        self.CurrentQueue.dateBegin = self.timeString
                        self.CurrentQueue.dateEnd = "--"
                        
                        
                        //Save Queue in CoreData
                        QueueManager.createQueue(newQueue: self.CurrentQueue)
                        //status OpenQueue
                        CONSTANT.saveQueueState(isOpenQueue: true, queueID: self.CurrentQueue.id)
                    }){
                        VStack(spacing: 30){
                        Image(systemName:  "plus.square.fill.on.square.fill").font(.system(size: 80))
                            Text("Cola Directa").font(.system(size: 17, weight: .semibold, design: .rounded))
                        }
                    }
                            
//                    Button(action: {
//                        self.isStarted = true
//                        self.queueType = CONSTANT.QueueType.VERIFY_Q
//                    }){
//                    VStack(spacing: 30){
//                    Image(systemName:  "text.badge.checkmark").font(.system(size: 80))
//                        Text("Cola Verificada").font(.system(size: 17, weight: .semibold, design: .rounded))
//                    }
//                    }
                        
                        
                    }
                }
                
            }
            .onAppear(perform: {
                if CONSTANT.isOpenQueue() && CONSTANT.getLastQueueID() != nil{
                    self.isStarted = true
                    self.CurrentQueue.id = CONSTANT.getLastQueueID()!
                    let Q = QueueManager.getQueueFromDB(predicate: NSPredicate(format: "id == %@", self.CurrentQueue.id))
                    
                    self.dateString = Q!.name!
                    self.timeString = Q!.dateBegin!
                    self.countOfClients = ClientsManager.getAllClients(queueID: self.CurrentQueue.id).count
                }
            })
            
            //MARK: NAVIGATION
            .navigationBarTitle(Text("\(self.isStarted ? "Cola" : "Porter@")"), displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    print("Closet Queue button tapped")
                    self.showAlet = true
                    CONSTANT.saveQueueState(isOpenQueue: false)
                }){
                    Image(systemName: "rectangle.stack.badge.minus").font(.system(size: 25)).accentColor(.red).disabled(!isStarted)
                }.disabled(!isStarted),
                
                trailing:
                NavigationLink(destination: RegisterQueueView()){
                    Text("Registro")
                }
//                NavigationLink(destination: GenerateQR()){
//                Image(systemName: "qrcode")
//                    .font(.system(size: 30))}
                
            )
                
                
            
        }
        .accentColor(Color.MyPrimaryColor)
        
    }
    //MARK: SCANNER HANDLER
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
                     self.isShowingScanner = false
                     self.showInfoScanned = false
                     // more code to come
                      switch result {
                      case .success(let code):
                          let details = code.components(separatedBy: "\r")
              //            guard details.count == 2 else {
              //                print("\(details.count) Datos raros: \(code)")
              //                return }
                          print(code)
                         let person = Prospect()
                          switch details.count {
                          case 2:
                              person.name = details[0]
                              person.data = details[1]
                              self.QRType = CONSTANT.QRType.QR_NAME_EMAIL
                              
                          case 5:
                              let xName = details[0].components(separatedBy: ":")
          //
                              let xLName = details[1].components(separatedBy: ":")
                              let xCi = details[2].components(separatedBy: ":")
                              print(xName)
                              
                              print("xn: \(xName) xLn: \(xLName)")
              //                  person.name = "\(details[0]) \(details[1])"
                              person.name = "\(xName[1]) \(xLName[1])"
                              person.data = "\(xCi[1])"
                              self.showInfoScanned = true
                              self.QRType = CONSTANT.QRType.QR_CI
                              
                          default:
                              print("details count :\(details.count)")
                              self.QRType = CONSTANT.QRType.QR_ANY
                             
                              
                          }

                          self.info = person
                          self.isStarted = true
                          
                      case .failure(let error):
                          print("Scanning failed \(error)")
                      }
                  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData())
    }
}

//MARK: HeaderView Struct

struct HeaderView: View {
    
   @Binding var name : String
   @Binding var data : String
   @Binding var typeQR: CONSTANT.QRType
   @Binding var isDenegate : Bool
    
    var body: some View {
        VStack(alignment: .leading){
            if isDenegate{
            Text("CLIENTE DENEGADO").font(.system(.largeTitle, design: .rounded))
            }
            Text("Cliente actual: \(name)").font(.system(.subheadline, design: .rounded)).fontWeight(.bold)
            Text("\(typeQR == CONSTANT.QRType.QR_NAME_EMAIL ? "Otro Dato" : "CI" ): \(data)").font(.system(.subheadline, design: .rounded)).bold()
        }.padding().frame(minWidth: 0, maxWidth: .infinity).foregroundColor(isDenegate ? Color.red :Color.black)
    }
}


extension ContentView{
    //MARK: It's ok Implementation
    func itsOK(){
            print("its ok")
    //                                self.showInfoScanned = false
            //Create Client
            let client = Client(id: UUID().uuidString, name: self.info.name, ci: self.info.data, denegateCount: 0, queueId: self.CurrentQueue.id)
            //if can update client not (3)
            if ClientsManager.updateClient(newClient: client, method: .ADD_DENEGATECOUNT){
                //Error sound
                 UIDevice.playSound(soundID: 1073)
                self.isDenegate = true
                //update queue
            }else {
            // (3) ADD Client a current Cola
                if QueueManager.updateQueue(With: client, queueId: self.CurrentQueue.id, queueAction: .ADD_CLIENT){
                    //ok sound and count++ 1073, accept 1111, cancel 1112
                    UIDevice.playSound(soundID: 1111)
                    self.isDenegate = false
                    self.countOfClients += 1
                   
                    print("Save Client in CurrentQueue")
                }else {
                    print("Error trying to save CurrentQueue")
                }
            }
    }
}
