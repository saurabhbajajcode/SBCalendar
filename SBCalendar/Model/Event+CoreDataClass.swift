//
//  Event+CoreDataClass.swift
//  SBCalendar
//
//  Created by Promobi on 02/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject {
    private class func getNewEventObject() -> Event {
        return NSEntityDescription.insertNewObject(forEntityName: "Event", into: CoreDataManager.context) as! Event
    }

    class func getAllEvents() -> [Event] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            let result = try CoreDataManager.context.fetch(fetchRequest)
            if let events = result as? [Event] {
                return events
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    class func getEvents(forDate dateString: String) -> [Event] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        let predicate = NSPredicate(format: "date == %@", dateString)
        fetchRequest.predicate = predicate
        do {
            let result = try CoreDataManager.context.fetch(fetchRequest)
            if let events = result as? [Event] {
                return events
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    class func createNewEvent(withDetails agenda: String) -> Event {
        let newObject = getNewEventObject()
        newObject.agenda = agenda
        return newObject
    }
}
