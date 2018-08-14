//
//  EventsListView.swift
//  SBCalendar
//
//  Created by Promobi on 02/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class EventsListView: UIView {

    @IBOutlet weak var tableView: UITableView!

    var expandedIndexPath: IndexPath?
    private var events: [Event]! = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
    }

    func setDataSource(dataSource: [Event]) {
            self.events = dataSource
    }
}

extension EventsListView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsListTableViewCellIdentifier") as! EventsListTableViewCell
        cell.setDataSource(dataSource: events[indexPath.row])
        if self.expandedIndexPath == indexPath {
            cell.participantsEmailLabelBottomConstraint.constant = cell.participantsEmailLabel.frame.height + 16
        } else {
            cell.participantsEmailLabelBottomConstraint.constant = 0
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indexPathsToReload = [indexPath]
        if self.expandedIndexPath != nil {
            indexPathsToReload.append(self.expandedIndexPath!)
        }
        if self.expandedIndexPath == indexPath {
            self.expandedIndexPath = nil
        } else {
            self.expandedIndexPath = indexPath
        }
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.expandedIndexPath = nil
        tableView.reloadData()
    }
}

