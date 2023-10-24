//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Anvar Rahimov on 06.01.2023.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "MMM yyyy"
        return dateFomatter.string(from: self)
    }
}
