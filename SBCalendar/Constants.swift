//
//  Constants.swift
//  SBCalendar
//
//  Created by Promobi on 31/07/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

let kTodaysDateTextColor = UIColor.white
let kTodaysDateBackgroundColor = UIColor.red

let kFutureDateTextColor = UIColor.darkText
let kFutureDateBackgroundColor = UIColor.white

let kPastDateTextColor = UIColor.gray
let kPastDateBackgroundColor = UIColor.white

enum EventDetailsKeys: String {
    case agenda = "agenda"
    case participants = "participants"
    case date = "eventDate"
    case time = "eventTime"
    case email = "email"
}
