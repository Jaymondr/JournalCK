//
//  DateFormatter.swift
//  Journal
//
//  Created by Jaymond Richardson on 5/10/21.
//

import Foundation
extension DateFormatter {
    
    static let entrytime: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}// End of extension
extension Date {
    
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
