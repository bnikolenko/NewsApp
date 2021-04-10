//
//  DateFormatterExtension.swift
//  NewsApp
//
//  Created by Bodia on 17.03.2021.
//  Copyright © 2021 Bodia. All rights reserved.
//

import Foundation

enum Formatter {
    case iso8601
    case monthYear
}

extension Formatter {
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static let monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, yyyy"
        return formatter
    }()
}

extension Date {
    func formatted(with formatter: Formatter) -> String {
        switch formatter {
        case .iso8601:
        return Formatter.iso8601Formatter.string(from: self)
        case .monthYear:
          return Formatter.monthYearFormatter.string(from: self)
        }
    }
}
