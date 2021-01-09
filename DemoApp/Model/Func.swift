//
//  Func.swift
//  DemoApp
//
//  Created by Yatharth Mahawar on 1/9/21.
//

import Foundation
import UIKit

func calcAge(birthday: String) -> Int {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "dd/MM/yyyy"
    let birthdayDate = dateFormater.date(from: birthday)
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .indian)
    let now = Date()
    let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
    let age = calcAge.year
    return age!
}

extension String {
    var vaildData:Bool {
        let firstName = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return firstName.evaluate(with: self)
    }
    var vaildNumber:Bool {
        let Number = NSPredicate(format: "SELF MATCHES %@", "[0-9]{10}")
        return Number.evaluate(with: self)
    }
}




