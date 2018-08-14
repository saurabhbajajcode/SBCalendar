//
//  CoreDataManager.swift
//  SBCalendar
//
//  Created by Promobi on 02/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let context = Appmanager.appDelegate.persistentContainer.viewContext
}
