//
//  ClientEntity+CoreDataProperties.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/15/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//
//

import Foundation
import CoreData


extension ClientEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClientEntity> {
        return NSFetchRequest<ClientEntity>(entityName: "ClientEntity")
    }

    @NSManaged public var ci: String?
    @NSManaged public var denegateCount: Int16
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var queueId: String?
    @NSManaged public var date: Date?
    @NSManaged public var queue: QueueEntity?

}
