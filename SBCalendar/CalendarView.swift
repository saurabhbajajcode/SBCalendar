//
//  CalendarView.swift
//  SBCalendar
//
//  Created by Promobi on 31/07/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class CalendarView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var monthView: MonthView!
    @IBOutlet weak var weekdaysView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var presentMonthIndex = 0
    var presentYear = 0
    var currentMonthIndex = 0
    var currentYear = 0
    var todaysDay = 0
    var firstWeekdayOfTheMonth = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        initialiseSubviews()
        monthView.delegate = self
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
        print(day == 8 ? 1 : day)
        return day == 8 ? 1 : day
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
            let day = indexPath.row - firstWeekdayOfTheMonth + 2
            cell.isHidden = false
            cell.dayLabel.text = "\(day)"
            if day < todaysDay && currentMonthIndex == presentMonthIndex && currentYear == presentYear {
                cell.isUserInteractionEnabled = false
                cell.dayLabel.backgroundColor = Constants.pastDateBackgroundColor
                cell.dayLabel.textColor = Constants.pastDateTextColor
            } else if day == todaysDay && currentMonthIndex == presentMonthIndex && currentYear == presentYear {
                cell.isUserInteractionEnabled = true
                cell.dayLabel.backgroundColor = Constants.todaysDateBackgroundColor
                cell.dayLabel.textColor = Constants.todaysDateTextColor
            } else {
                cell.isUserInteractionEnabled = true
                cell.dayLabel.backgroundColor = Constants.futureDateBackgroundColor
                cell.dayLabel.textColor = Constants.futureDateTextColor
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print((collectionView.cellForItem(at: indexPath) as! DaysCell).dayLabel.text as? Any)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = self.frame.width
        return CGSize(width: totalWidth/7, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        let totalMargin = self.frame.width - CGFloat(40*7)
//        return totalMargin/9
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
    func didChangeMonth(monthIndex: Int, year:Int) {
        currentYear = year
        currentMonthIndex = monthIndex
        firstWeekdayOfTheMonth = getFirstDayOfTheMonth()
        collectionView.reloadData()
        monthView.leftButton.isEnabled = !(currentYear == presentYear && currentMonthIndex == presentMonthIndex)
    }
}
