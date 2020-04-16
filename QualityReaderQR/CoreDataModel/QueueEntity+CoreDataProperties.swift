//
//  QueueEntity+CoreDataProperties.swift
//  QualityReaderQR
//
//  Created by Wilder Lopez on 4/15/20.
//  Copyright © 2020 Wilder Lopez. All rights reserved.
//
//

import Foundation
import CoreData


extension QueueEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QueueEntity> {
        return NSFetchRequest<QueueEntity>(entityName: "QueueEntity")
    }

    @NSManaged public var dateBegin: String?
    @NSManaged public var dateEnd: String?
    @NSManaged public var denegateClients: Int16
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var clients: NSOrderedSet?

}

// MARK: Generated accessors for clients
extension QueueEntity {

    @objc(insertObject:inClientsAtIndex:)
    @NSManaged public func insertIntoClients(_ value: ClientEntity, at idx: Int)

    @objc(removeObjectFromClientsAtIndex:)
    @NSManaged public func removeFromClients(at idx: Int)

    @objc(insertClients:atIndexes:)
    @NSManaged public func insertIntoClients(_ values: [ClientEntity], at indexes: NSIndexSet)

    @objc(removeClientsAtIndexes:)
    @NSManaged public func removeFromClients(at indexes: NSIndexSet)

    @objc(replaceObjectInClientsAtIndex:withObject:)
    @NSManaged public func replaceClients(at idx: Int, with value: ClientEntity)

    @objc(replaceClientsAtIndexes:withClients:)
    @NSManaged public func replaceClients(at indexes: NSIndexSet, with values: [ClientEntity])

    @objc(addClientsObject:)
    @NSManaged public func addToClients(_ value: ClientEntity)

    @objc(removeClientsObject:)
    @NSManaged public func removeFromClients(_ value: ClientEntity)

    @objc(addClients:)
    @NSManaged public func addToClients(_ values: NSOrderedSet)

    @objc(removeClients:)
    @NSManaged public func removeFromClients(_ values: NSOrderedSet)

}
