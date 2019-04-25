//
//  HelperDateExtension.swift
//  Cruncher
//
//  Created by Luan Nguyen on 2019-04-14.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    func calenderTimeSinceNow() -> String
    {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        let years = components.year!
        let months = components.month!
        let days = components.day!
        let hours = components.hour!
        let minutes = components.minute!
        let seconds = components.second!
        
        if years > 0 {
            return years == 1 ? "\(NSLocalizedString("1", comment: ""))" : "\(years)  \(NSLocalizedString("2", comment: ""))"
        } else if months > 0 {
            return months == 1 ?  "\(NSLocalizedString("3", comment: "")) " : "\(months) \(NSLocalizedString("4", comment: ""))"
        } else if days >= 7 {
            let weeks = days / 7
            return weeks == 1 ? "\(NSLocalizedString("5", comment: ""))" : "\(weeks)  \(NSLocalizedString("6", comment: ""))"
        } else if days > 0 {
            return days == 1 ? " \(NSLocalizedString("7", comment: ""))" : "\(days)  \(NSLocalizedString("8", comment: ""))"
        } else if hours > 0 {
            return hours == 1 ? " \(NSLocalizedString("9", comment: ""))" : "\(hours) \(NSLocalizedString("10", comment: ""))"
        } else if minutes > 0 {
            return minutes == 1 ? " \(NSLocalizedString("11", comment: ""))" : "\(minutes)  \(NSLocalizedString("12", comment: ""))"
        } else {
            return seconds == 1 ? " \(NSLocalizedString("13", comment: ""))" : "\(seconds)  \(NSLocalizedString("14", comment: ""))"
        }
    }

}
