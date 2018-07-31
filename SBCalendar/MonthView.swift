//
//  MonthView.swift
//  SBCalendar
//
//  Created by Promobi on 31/07/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

protocol monthViewDelegate: class {
    func didChangeMonth(monthIndex: Int, year:Int)
}

class MonthView: UIView {

    @IBOutlet weak var monthLabel: UILabel!

    var delegate: monthViewDelegate?
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    @IBAction func leftButtonTapped(_ sender: UIButton) {
        switch currentMonthIndex {
        case 0:
            self.currentMonthIndex = 11

        default:
            self.currentMonthIndex -= 1
        }
        let title = months[currentMonthIndex]
        self.monthLabel.text = title
        self.delegate?.didChangeMonth(monthIndex: sender.tag, year: self.currentYear)
    }

    @IBAction func rightButtonTapped(_ sender: UIButton) {
        switch currentMonthIndex {
        case 11:
            self.currentMonthIndex = 0

        default:
            self.currentMonthIndex += 1
        }
        let title = months[currentMonthIndex]
        self.monthLabel.text = title
        self.delegate?.didChangeMonth(monthIndex: sender.tag, year: self.currentYear)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let currentDate = Date()
        let currentMonth = NSCalendar.current.component(.month, from: currentDate)
        let currentYear = NSCalendar.current.component(.year, from: currentDate)
        self.currentMonthIndex = currentMonth
        self.currentYear = currentYear
        self.monthLabel.text = months[currentMonth]
    }
}
