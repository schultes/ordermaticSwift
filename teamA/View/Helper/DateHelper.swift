//
//  DateHelper.swift
//  teamA
//
//  Created by FMA1 on 01.08.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation

extension String {
    
    func formatDate() -> String {
        let year = substring(to: 4)
        let month = substring(with: 5..<7)
        let day = substring(from: 8)
        
        var monthName = ""
        
        switch month {
            case "01": monthName = "Januar"
            case "02": monthName = "Februar"
            case "03": monthName = "März"
            case "04": monthName = "April"
            case "05": monthName = "Mai"
            case "06": monthName = "Juni"
            case "07": monthName = "Juli"
            case "08": monthName = "August"
            case "09": monthName = "September"
            case "10": monthName = "Oktober"
            case "11": monthName = "November"
            case "12": monthName = "Dezember"
            default: monthName = ""
        }
        
        return "\(day).\(monthName).\(year)"
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
