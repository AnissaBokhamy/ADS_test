//
//  DateExtension.swift
//  ADS-test
//
//  Created by Anissa Bokhamy on 08/05/2021.
//

import Foundation

extension Date {
    func formatWithDateAndTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
