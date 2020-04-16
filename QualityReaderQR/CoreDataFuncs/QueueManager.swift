//
//  QueueManager.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/12/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct QueueManager {
    
   static var appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
   static func createQueue(newQueue: Queue){
        
        let context: NSManagedObjectContext = appDelegate.coreDataStack.managedContext
//
        let ent = NSEntityDescription.entity(forEntityName: "QueueEntity", in: context)!

        let queue = QueueEntity(entity: ent, insertInto: context)
    
        
        queue.id = newQueue.id
        queue.dateBegin = newQueue.dateBegin
        queue.dateEnd = newQueue.dateEnd
        queue.denegateClients = newQueue.denegateClients
        queue.name = newQueue.name
        
        
        do {
            try context.save()
            print("Save Queue ok")
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
   static func updateQueue(With newClient: Client = Client(), queueId: String = "" , queueAction: CONSTANT.QueueUpdateAction) -> Bool {
        
        switch queueAction {
        case .ADD_CLIENT:
//            guard let QueueCD : QueueEntity = self.getQueueFromDB(predicate: NSPredicate(format: "id == %@", newClient.queueId)) else { return false }
            
//            QueueCD.clients.append(newClient)
//            guard let currentQueue = QueueManager.getQueueFromDB(predicate: NSPredicate(format: "id == %@ ", newClient.queueId)) else {return false}
            ClientsManager.createClient(newClient: newClient)
        default:
            //FINISH QUEUE
            guard let QueueCD : QueueEntity = self.getQueueFromDB(predicate: NSPredicate(format: "id == %@", queueId)) else { return false }
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            QueueCD.dateEnd = formatter.string(from: Date())
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
        
    static public func getQueueFromDB(predicate : NSPredicate) -> QueueEntity? {
            
            let context: NSManagedObjectContext = appDelegate.coreDataStack.managedContext
            
            let entity = NSEntityDescription.entity(forEntityName: "QueueEntity", in: context)
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            fetchRequest.entity = entity
    //        let predicate = NSPredicate(format:"username == %@", username)
            fetchRequest.predicate = predicate
            
            do {
                let results = try context.fetch(fetchRequest)
                guard let queue = (results as? [QueueEntity])?.first else { return nil }
                return queue
            } catch let error as NSError {
                print("Unable to Fetch Client \(error), \(error.userInfo)")
            }
            
            return nil
        }
    
    static func FetchQueueData() -> [QueueEntity]{
        
            let context: NSManagedObjectContext = appDelegate.coreDataStack.managedContext

    //        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "UserRosterEntity")

            let fQ : NSFetchRequest<QueueEntity> = QueueEntity.fetchRequest()

            do{

    //            let usr = try context.fetch(request)

                let f = try context.fetch(fQ)
                 let queues : [QueueEntity] = f
//                for C in queues{
//                    print("->name: \(String(describing: C.name)) ->count of clients: \(C.clients.count)")
    //                do{
    //                try print("+++______   UserName: \(C.username) -> \(String(describing: C.userInfo.alias))")
    //                } catch{
    //                    print("Error")
    //                }
//                }
                return queues
            }catch let error as NSError{
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            return [QueueEntity]()
        }
    
    
    static func getAllQueue() -> [Queue]{
        let queues = self.FetchQueueData()
        
        var Qs = [Queue]()
        
        for q in queues{
            var qq = Queue()
            qq.id = q.id!
            qq.name = q.name!
            qq.dateBegin = q.dateBegin!
            qq.dateEnd = q.dateEnd!
            qq.denegateClients = q.denegateClients
//            qq.clients = q.clients
            Qs.append(qq)
        }
        return Qs
    }
    
}
