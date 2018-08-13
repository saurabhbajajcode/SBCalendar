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

    // MARK: helper methods
    private func navigateToEventsList() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddEventViewController: AddEventViewDelegate {
    func saveNewEvent(eventDetails: [String : AnyObject]) {
        let event = Event.createNewEvent(withDetails: eventDetails[EventDetailsKeys.agenda.rawValue] as! String)
        event.date = eventDetails[EventDetailsKeys.date.rawValue] as? Date
        event.time = eventDetails[EventDetailsKeys.time.rawValue] as? String

        let participantsString = eventDetails[EventDetailsKeys.participants.rawValue]
        let participantsArray = participantsString?.components(separatedBy: ", ")
        for participantEmail in participantsArray! {
            let participant = Participant.insertParticipant(withEmail: participantEmail)
            participant.events = NSSet(set: (participant.events?.adding(event))!)
        }
        Appmanager.appDelegate.saveContext()
        Appmanager.showToast(message: "Event saved.")
        self.navigateToEventsList()
    }
}
