//
//  Date+SameDayAs.swift
//  Miqi
//
//  Created by Jonathan Solorzano on 29/4/22.
//

import Foundation

extension Date {
    
    var startOfDay: Date {
        var currentCalendar = Calendar.current
        currentCalendar.timeZone = .current
        
        return currentCalendar.startOfDay(for: self)
    }
    
    func sameDayAs(_ date: Date) -> Bool {
        
        var currentCalendar = Calendar.current
        currentCalendar.timeZone = .current
        
        return currentCalendar.compare(self, to: date, toGranularity: .day) == .orderedSame
            && currentCalendar.compare(self, to: date, toGranularity: .month) == .orderedSame
            && currentCalendar.compare(self, to: date, toGranularity: .year) == .orderedSame
    }
    
}
