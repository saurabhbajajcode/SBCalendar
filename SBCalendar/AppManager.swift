//
//  AppManager.swift
//  SBCalendar
//
//  Created by Promobi on 31/07/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import Foundation
import UIKit

class Appmanager: NSObject {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate

    class func showToast(message: String) {
        appDelegate.window?.rootViewController?.view.showToast(message: message)
    }
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

    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}

extension UIView {
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 50, y: 120, width: self.frame.size.width - 100, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 3.5, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
