//
//  EventsListViewController.swift
//  SBCalendar
//
//  Created by Promobi on 01/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class EventsListViewController: UIViewController {

    private var selectedDate: Date! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            self.title = dateFormatter.string(from: selectedDate)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEventsList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setSelectedDate(date: Date) {
        self.selectedDate = date
    }

    // MARK: callbacks
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func addEventButtonTapped() {
        self.performSegue(withIdentifier: "showAddEventScene", sender: self)
    }

    // MARK: helpers
    func setupNavigationBar() {
        self.navigationItem.backBarButtonItem = nil

        // back button
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backButton.setImage(#imageLiteral(resourceName: "leftDark"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let backBarButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButton

        // add event button
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEventButtonTapped))
        self.navigationItem.rightBarButtonItem = addBarButton
    }

    private func fetchEventsList() {
        let events = Event.getEvents(forDate: selectedDate)
        print("\n\n*****************************************************", events)
        (self.view as? EventsListView)?.setDataSource(dataSource: events)
    }
}
