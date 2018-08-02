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

    func isValidEmail() -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let emailTestPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTestPredicate.evaluate(with: self)
        return result
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
