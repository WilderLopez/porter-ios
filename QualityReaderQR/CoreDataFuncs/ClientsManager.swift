//
//  ClientsManager.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/12/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct ClientsManager {
    
//    var currentQueue : Queue
//    
//    init(Current queue: Queue) {
//        self.currentQueue = queue
//    }
    
//    init() {
//    }
    static let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
       static func createClient(newClient: Client){
            let context: NSManagedObjectContext = appDelegate.coreDataStack.managedContext
    //
            let ent = NSEntityDescription.entity(forEntityName: "ClientEntity", in: context)!

            let client = ClientEntity(entity: ent, insertInto: context)
        
            client.id = newClient.id
            client.ci = newClient.ci
            client.name = newClient.name
            client.denegateCount = newClient.denegateCount
            client.queueId = newClient.queueId
            client.date = Date()
            
//        if let currentQueue = QueueManager.getQueueFromDB(predicate: NSPredicate(format: "id == %@ ", newClient.queueId)), let clients = currentQueue.clients?.mutableCopy() as? NSMutableOrderedSet{
//            clients.add(client)
//            currentQueue.clients = clients
//        }
        
        let currentQueue = QueueManager.getQueueFromDB(predicate: NSPredicate(format: "id == %@ ", newClient.queueId))
        currentQueue?.addToClients(client)
            
//        print("Client ready to save \(client.id)")
            do {
                try context.save()
                print("Save clients ok")
            }catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
    
    static func updateClient(newClient: Client,method: CONSTANT.ClientUpdateAction) -> Bool {
        
//         let username : String = newClient.id
//        guard let ClientCD : ClientEntity = self.getClientFromDB( predicate: NSPredicate(format: "ci == %@ AND queueId == %@", argumentArray: [newClient.ci, newClient.queueId])) else { return false }
        
        guard let currentQueue = QueueManager.getQueueFromDB(predicate: NSPredicate(format: "id == %@ ", newClient.queueId)) else {return false}
        let clients = currentQueue.clients?.mutableCopy() as? NSMutableOrderedSet
                        
        guard let ClientCD = clients?.filtered(using: NSPredicate(format: "ci == %@", newClient.ci)).firstObject as! ClientEntity? else {return false}
                        
        
        if method == .ADD_DENEGATECOUNT{
//            guard let Q = QueueManager.getQueueFromDB(predicate: NSPredicate(format: "id == %@ ", argumentArray: [newClient.queueId])) else {return false}
//            for q in Q.clients{
//                if q.ci == newClient.ci{
//                    q.denegateCount += 1
//                    break
//                }
//            }
        ClientCD.denegateCount += 1
        currentQueue.denegateClients += 1
        print("Client ready to update denegateCount")
        }else if method == .UPDATE_ALL{
            ClientCD.id = newClient.id
            ClientCD.ci = newClient.ci
            ClientCD.name = newClient.name
            ClientCD.denegateCount = newClient.denegateCount
            ClientCD.queueId = newClient.queueId
            print("client ready to update : \(ClientCD)")
        }
        
        
        let context: NSManagedObjectContext = appDelegate.coreDataStack.managedContext
        
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Unable not Update Employee \(error), \(error.userInfo)")
        }
        
        return false
    }
    
   static public func getClientFromDB(predicate : NSPredicate) -> ClientEntity? {
        
       
        let context: NSManagedObjectContext = appDelegate.coreDataStack.managedContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ClientEntity", in: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entity
//        let predicate = NSPredicate(format:"username == %@", username)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            guard let client = (results as? [ClientEntity])?.first else { return nil }
            return client
        } catch let error as NSError {
            print("Unable to Fetch Client \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    static func FetchClientsData(predicate: NSPredicate? = nil) -> [ClientEntity]{
//            let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.coreDataStack.managedContext

    //        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "UserRosterEntity")

            let fQ : NSFetchRequest<ClientEntity> = ClientEntity.fetchRequest()
                if predicate != nil{
                    fQ.predicate = predicate
                }
        
            do{

    //            let usr = try context.fetch(request)

                let f = try context.fetch(fQ)
                 let clients : [ClientEntity] = f
//                for C in clients{
                ////                    print("->name: \(C.name) ->ci: \(String(describing: C.ci))")
//    //                do{
//    //                try print("+++______   UserName: \(C.username) -> \(String(describing: C.userInfo.alias))")
//    //                } catch{
//    //                    print("Error")
//    //                }
//                }
                return clients
            }catch let error as NSError{
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            return [ClientEntity]()
        }
    
    static func getAllClients(queueID: String) -> [Client]{
           let clients = self.FetchClientsData(predicate: NSPredicate(format: "queueId == %@", queueID))
           
           var Qs = [Client]()
           
           for c in clients{
            if c.queueId == queueID{
            let qq = Client()
               qq.id = c.id!
               qq.name = c.name!
               qq.ci = c.ci!
               qq.denegateCount = c.denegateCount
               qq.queueId = c.queueId!
                Qs.append(qq)
                
            }
           }
           return Qs
       }
    
    static func countOfClientsDenegate(queueID: String) -> Int{
        return self.FetchClientsData(predicate: NSPredicate(format: "queueId == %@ AND denegateCount > 0", queueID)).count
    }

}
