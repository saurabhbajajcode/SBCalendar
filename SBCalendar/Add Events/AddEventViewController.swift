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
        
    }
}
