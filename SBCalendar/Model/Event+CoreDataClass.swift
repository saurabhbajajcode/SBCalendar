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

    class func getEvents(forDate date: Date) -> [Event] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        let predicate = NSPredicate(format: "date > %@", date as CVarArg)
        let nextDay = NSCalendar.current.date(byAdding: .day, value: 1, to: date)
        let predicate2 = NSPredicate(format: "date < %@", nextDay! as CVarArg)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate2])
        fetchRequest.predicate = compoundPredicate
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

    class func getEvents(forMonth month: Int, year: Int, date: Date) -> [Event] {
        let calendar = Calendar.current
        let startDate = Calendar.current.date(from: DateComponents(calendar: calendar, timeZone: calendar.timeZone, era: nil, year: year, month: month, day: 1, hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil))
        let endDate = startDate!.endOfMonth()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        let predicate = NSPredicate(format: "date > %@", startDate! as CVarArg)
        let predicate2 = NSPredicate(format: "date < %@", endDate as CVarArg)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate, predicate2])
        fetchRequest.predicate = compoundPredicate
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
