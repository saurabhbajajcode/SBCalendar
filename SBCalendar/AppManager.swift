//
//  AppManager.swift
//  SBCalendar
//
//  Created by Promobi on 31/07/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import Foundation

class Appmanager: NSObject {

}

extension String {
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }()

    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }

    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.month, .year], from: self))!
    }
}
