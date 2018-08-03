//
//  MonthView.swift
//  SBCalendar
//
//  Created by Promobi on 31/07/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

protocol MonthViewDelegate: class {
    func didChangeMonth(monthIndex: Int, year:Int)
}

class MonthView: UIView {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    var delegate: MonthViewDelegate?
    var currentMonthIndex: Int = 0
    var currentYear: Int = 0
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    @IBAction func leftButtonTapped(_ sender: UIButton) {
        self.currentMonthIndex -= 1
        if self.currentMonthIndex < 0 {
            self.currentMonthIndex = 11
            self.currentYear -= 1
        }
        self.monthLabel.text = "\(months[currentMonthIndex]) \(currentYear)"
        self.delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: self.currentYear)
    }

    @IBAction func rightButtonTapped(_ sender: UIButton) {
        self.currentMonthIndex += 1
        if self.currentMonthIndex > 11 {
            self.currentMonthIndex = 0
            self.currentYear += 1
        }
        self.monthLabel.text = "\(months[currentMonthIndex]) \(currentYear)"
        if !leftButton.isEnabled {
            leftButton.isEnabled = true
        }
        self.delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: self.currentYear)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let currentDate = Date()
        let currentMonth = NSCalendar.current.component(.month, from: currentDate)
        let currentYear = NSCalendar.current.component(.year, from: currentDate)
        self.currentMonthIndex = currentMonth-1
        self.currentYear = currentYear
        self.monthLabel.text = "\(months[self.currentMonthIndex]) \(self.currentYear)"
        leftButton.isEnabled = false
    }
}
