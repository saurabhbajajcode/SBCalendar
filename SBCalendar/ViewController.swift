//
//  ViewController.swift
//  SBCalendar
//
//  Created by Promobi on 31/07/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        (self.view as? CalendarView)?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        (self.view as? CalendarView)?.collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ViewController: CalendarViewDelegate {
    func didSelectDate(day: Int, month: Int, year: Int) {
        // show events list view controller
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let eventsListVC = storyBoard.instantiateViewController(withIdentifier: "eventsListScene") as! EventsListViewController
        let selectedDate = "\(day)-\(month+1)-\(year)".date
        print(selectedDate)
        eventsListVC.setSelectedDate(date: selectedDate!)
        self.navigationController?.pushViewController(eventsListVC, animated: true)
    }
}
