//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by Baris Karalar on 26.08.2021.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
