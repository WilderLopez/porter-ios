//
//  Model.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/12/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import Foundation
import CoreData

public class Client : NSObject, NSCoding{
   
    public func encode(with coder: NSCoder) {
        coder.encode(self.id)
        coder.encode(self.ci)
        coder.encode(self.name)
        coder.encode(self.denegateCount)
        coder.encode(self.queueId)
    }
    
    public required convenience init(coder decode: NSCoder) {
        let values = Client()
        values.id = decode.decodeObject() as! String
        values.name = decode.decodeObject() as! String
        values.ci = decode.decodeObject() as! String
        values.denegateCount = decode.decodeObject() as! Int16
        values.queueId = decode.decodeObject() as! String
        
        self.init(id: values.id, name: values.name, ci: values.ci, denegateCount: values.denegateCount, queueId: values.queueId )
    }
    
    var id: String
    var name: String
    var ci: String
    var denegateCount: Int16
    var queueId: String
    
    init(id: String, name: String, ci: String, denegateCount: Int16, queueId: String) {
        self.id = id
        self.ci = ci
        self.name = name
        self.denegateCount = denegateCount
        self.queueId = queueId
        
    }
    
    override init() {
        self.id = ""
        self.ci = ""
        self.name = ""
        self.denegateCount = 0
        self.queueId = ""
    }
    
}

struct Queue : Identifiable, Hashable{
    var id: String
    var name: String
    var dateBegin: String
    var dateEnd: String
    var clients : [Client]
    var denegateClients: Int16
    
    init() {
        self.id = ""
        self.clients = [Client]()
        self.dateBegin = ""
        self.dateEnd = ""
        self.denegateClients = 0
        self.name = ""
        
    }
    
}
