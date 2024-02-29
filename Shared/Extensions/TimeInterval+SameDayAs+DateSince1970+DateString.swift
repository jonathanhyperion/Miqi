//
//  TimeInterval+SameDayAs.swift
//  Miqi
//
//  Created by Jonathan Solorzano on 29/4/22.
//

import Foundation

extension TimeInterval {
    
    var dateSince1970: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    var dateDDMMYYYY: String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMYYYY"
        
        return dateFormatter.string(from: dateSince1970)
    }
    
    func isSameDayAs(_ timeInterval: TimeInterval) -> Bool {
        return self.dateSince1970.sameDayAs(timeInterval.dateSince1970)
    }
}
