//
//  QueueEntity+CoreDataProperties.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/12/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//
//

import Foundation
import CoreData


extension QueueEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QueueEntity> {
        return NSFetchRequest<QueueEntity>(entityName: "QueueEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var dateBegin: String?
    @NSManaged public var dateEnd: String?
    @NSManaged public var denegateClients: Int16
    @NSManaged public var clients: [Client]
    @NSManaged public var id: String?

}
