//
//  ADS_testUITestsHelper.swift
//  ADS-testUITests
//
//  Created by Anissa Bokhamy on 10/05/2021.
//

import Foundation
import XCTest

class ADS_testUITestsHelper {
    
    static func textView(named textViewIdentifier: String, contains string: String, in app: XCUIApplication) -> Bool {
        let textView = app.textViews[textViewIdentifier]
        guard let text = textView.value as? String else { return false }
        return text.contains(string)
    }
    
    static func buttonAddsTimestampToAllTextViews(buttonIdentifier: String, in app: XCUIApplication) -> Bool {
        app.swipeRight()
        
        let tapDate = Date()
        app.buttons[buttonIdentifier].tap()
        
        var textViewsContainTimestamp:[Bool] = []
        
        let textViewsIdentifiers = UITestsConstants.TextViews.allCases.compactMap { "\($0)" }
        textViewsIdentifiers.forEach { textViewIdentifier in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss"
            let formattedTapDate = dateFormatter.string(from: tapDate)

            textViewsContainTimestamp.append(
                ADS_testUITestsHelper.textView(named: textViewIdentifier, contains: formattedTapDate, in: app)
            )
        }
        let allTextViewsContainTimestamp = textViewsContainTimestamp.filter({ $0 }).count == textViewsIdentifiers.count
        return allTextViewsContainTimestamp
    }
}
