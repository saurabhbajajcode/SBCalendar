//
//  AddEventViewController.swift
//  SBCalendar
//
//  Created by Promobi on 01/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        (self.view as? AddEventView)?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddEventViewController: AddEventViewDelegate {
    func saveNewEvent(eventDetails: [String : String]) {
        let event = Event.createNewEvent(withDetails: eventDetails[EventDetailsKeys.agenda.rawValue]!)
        event.date = eventDetails[EventDetailsKeys.date.rawValue]
        event.time = eventDetails[EventDetailsKeys.time.rawValue]

        let participantsString = eventDetails[EventDetailsKeys.participants.rawValue]
        let participantsArray = participantsString?.components(separatedBy: ", ")
        for participantEmail in participantsArray! {
            let participant = Participant.insertParticipant(withEmail: participantEmail)
            participant.events = NSSet(set: (participant.events?.adding(event))!)
        }
        Appmanager.appDelegate.saveContext()
    }
}
