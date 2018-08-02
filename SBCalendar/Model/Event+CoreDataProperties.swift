//
//  Event+CoreDataProperties.swift
//  SBCalendar
//
//  Created by Promobi on 02/08/18.
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
    @NSManaged public var date: String?
    @NSManaged public var time: String?
    @NSManaged public var participants: Participant?

}
