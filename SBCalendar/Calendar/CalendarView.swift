//
//  CalendarView.swift
//  SBCalendar
//
//  Created by Promobi on 31/07/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

protocol CalendarViewDelegate: class {
    func didSelectDate(day: Int, month: Int, year: Int)
    func getAllEvents(forMonth month: Int, year:Int)
}

class CalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var monthView: MonthView!
    @IBOutlet weak var weekdaysView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    var delegate: CalendarViewDelegate? {
        didSet {
            self.delegate?.getAllEvents(forMonth: currentMonthIndex+1, year: currentYear)
        }
    }
    private var eventsForCurrentMonth: [Event]?
    var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var presentMonthIndex = 0
    var presentYear = 0
    var currentMonthIndex = 0
    var currentYear = 0
    var todaysDay = 0
    var firstWeekdayOfTheMonth = 0
    var daysArray: [Int]?

    override func awakeFromNib() {
        super.awakeFromNib()
        initialiseSubviews()
        monthView.delegate = self
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        self.delegate?.getAllEvents(forMonth: currentMonthIndex+1, year: currentYear)
    }

    // MARK: helpers
    private func initialiseSubviews() {
        let currentDate = Date()
        self.currentYear = NSCalendar.current.component(.year, from: currentDate)
        self.currentMonthIndex = NSCalendar.current.component(.month, from: currentDate) - 1
        self.todaysDay = NSCalendar.current.component(.day, from: currentDate)
        presentMonthIndex = self.currentMonthIndex
        presentYear = currentYear

        firstWeekdayOfTheMonth = getFirstDayOfTheMonth()
    }

    private func getFirstDayOfTheMonth() -> Int {
        let day = ("01-\(currentMonthIndex+1)-\(currentYear)".date?.firstDayOfTheMonth.weekday)!
        return day == 8 ? 1 : day
    }

    // MARK: callbacks
    func showEventIndicators(forEvents events: [Event]) {
        self.eventsForCurrentMonth = events
        let datesArray = self.eventsForCurrentMonth?.compactMap({ $0.date })
        let daysArray = datesArray?.compactMap({ return Calendar.current.component(.day, from: $0) })
        self.daysArray = daysArray
        self.collectionView.reloadData()
    }

    // MARK: collection view methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInMonth[currentMonthIndex] + firstWeekdayOfTheMonth - 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath) as! DaysCell
        if indexPath.row < firstWeekdayOfTheMonth - 1 {
            cell.isHidden = true
        } else {
            cell.isHidden = false
            let day = indexPath.row - firstWeekdayOfTheMonth + 2
            cell.dayLabel.text = "\(day)"

            // show event indicator if there is an event scheduled for the day
            if self.daysArray?.contains(day) == true {
                cell.eventIndicatorView.isHidden = false
            } else {
                cell.eventIndicatorView.isHidden = true
            }

            if day < todaysDay && currentMonthIndex == presentMonthIndex && currentYear == presentYear {
                // disable user interaction for past dates
                cell.isUserInteractionEnabled = false
                cell.dayLabel.backgroundColor = kPastDateBackgroundColor
                cell.dayLabel.textColor = kPastDateTextColor
            } else if day == todaysDay && currentMonthIndex == presentMonthIndex && currentYear == presentYear {
                // highlight today's date
                cell.isUserInteractionEnabled = true
                cell.dayLabel.backgroundColor = kTodaysDateBackgroundColor
                cell.dayLabel.textColor = kTodaysDateTextColor
            } else {
                // show future dates as usual
                cell.isUserInteractionEnabled = true
                cell.dayLabel.backgroundColor = kFutureDateBackgroundColor
                cell.dayLabel.textColor = kFutureDateTextColor
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print((collectionView.cellForItem(at: indexPath) as! DaysCell).dayLabel.text as Any)
        if let dayString = (collectionView.cellForItem(at: indexPath) as! DaysCell).dayLabel.text, dayString.isEmpty == false {
            let day = (dayString as NSString).integerValue
            self.delegate?.didSelectDate(day: day, month: currentMonthIndex, year: currentYear)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = self.frame.width - 16
        return CGSize(width: totalWidth/7, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight {
            return 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}

extension CalendarView: MonthViewDelegate {
    /// updates 
    func didChangeMonth(monthIndex: Int, year:Int) {
        currentYear = year
        currentMonthIndex = monthIndex
        firstWeekdayOfTheMonth = getFirstDayOfTheMonth()
        collectionView.reloadData()
        monthView.leftButton.isEnabled = !(currentYear == presentYear && currentMonthIndex == presentMonthIndex)

        self.delegate?.getAllEvents(forMonth: currentMonthIndex+1, year: currentYear)
    }
}
