//
//  Event+CoreDataProperties.swift
//  SBCalendar
//
//  Created by Saurabh on 10/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var agenda: String?
    @NSManaged public var date: Date?
    @NSManaged public var time: String?
    @NSManaged public var participants: NSSet?

}

// MARK: Generated accessors for participants
extension Event {

    @objc(addParticipantsObject:)
    @NSManaged public func addToParticipants(_ value: Participant)

    @objc(removeParticipantsObject:)
    @NSManaged public func removeFromParticipants(_ value: Participant)

    @objc(addParticipants:)
    @NSManaged public func addToParticipants(_ values: NSSet)

    @objc(removeParticipants:)
    @NSManaged public func removeFromParticipants(_ values: NSSet)

}
