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
    
       static func createClient(newClient: Client){
            let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
    //
            let ent = NSEntityDescription.entity(forEntityName: "ClientEntity", in: context)!

            let client = ClientEntity(entity: ent, insertInto: context)
        
            client.id = newClient.id
            client.ci = newClient.ci
            client.name = newClient.name
            client.denegateCount = newClient.denegateCount
            client.queueId = newClient.queueId
                
            
            do {
                try context.save()
                print("Save clients ok")
            }catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
            
        }
    
    static func updateClient(newClient: Client) -> Bool {
        
//         let username : String = newClient.id
        guard let ClientCD : ClientEntity = self.getClientFromDB(predicate: NSPredicate(format: "id == %@ AND queueId == %@", newClient.id, newClient.queueId)) else { return false }
        
        ClientCD.denegateCount = newClient.denegateCount
       
        
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Unable not Update Employee \(error), \(error.userInfo)")
        }
        
        return false
    }
    
   static public func getClientFromDB(predicate : NSPredicate) -> ClientEntity? {
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
        
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
    
//       static func FetchUserRosterData() -> [UserRosterCD]{
//            let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context: NSManagedObjectContext = appDel.persistentContainer.viewContext
//
//    //        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "UserRosterEntity")
//
//            let fQ : NSFetchRequest<UserRosterCD> = UserRosterCD.fetchRequest()
//
//            do{
//
//    //            let usr = try context.fetch(request)
//
//                let f = try context.fetch(fQ)
//                 let userx : [UserRosterCD] = f
//                for C in userx{
//                    print("->Username: \(C.username) ->Version: \(C.version)")
//    //                do{
//    //                try print("+++______   UserName: \(C.username) -> \(String(describing: C.userInfo.alias))")
//    //                } catch{
//    //                    print("Error")
//    //                }
//                }
//                return userx
//            }catch let error as NSError{
//                print("Could not fetch. \(error), \(error.userInfo)")
//            }
//            return [UserRosterCD]()
//        }
//
}
