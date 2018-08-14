//
//  Participant+CoreDataClass.swift
//  SBCalendar
//
//  Created by Promobi on 02/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Participant)
public class Participant: NSManagedObject {

    private class func newParticipant() -> Participant {
        return NSEntityDescription.insertNewObject(forEntityName: "Participant", into: CoreDataManager.context) as! Participant
    }

    class func getAllParticipants() -> [Participant]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Participant")
        do {
            let result = try CoreDataManager.context.fetch(fetchRequest)
            if let participantsArray = result as? [Participant] {
                return participantsArray
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    class func getParticipant(withEmail email: String) -> Participant? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Participant")
        let predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.predicate = predicate
        do {
            let result = try CoreDataManager.context.fetch(fetchRequest)
            if let participantsArray = result as? [Participant] {
                return participantsArray.first
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    class func insertParticipant(withEmail email: String) -> Participant{
        if let participant = getParticipant(withEmail: email) {
            return participant
        }
        let participant = newParticipant()
        participant.email = email
        return participant
    }
}
