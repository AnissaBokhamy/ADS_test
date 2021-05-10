//
//  TextViewHelper.swift
//  ADS-test
//
//  Created by Anissa Bokhamy on 10/05/2021.
//

import Foundation
import UIKit

class TextViewHelper {
    static func generateAttributedText(for timestamps: [Date]) -> NSAttributedString {
        let textSize: CGFloat = 14
        
        let headerText = "UIScrollView\n\n"
        let timestampLines = timestamps.reversed().compactMap{ "\($0.formatWithDateAndTime())\n" }.joined()
        let text = headerText + timestampLines
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributedText = NSMutableAttributedString(string: text, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: textSize), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let headerTextRange = NSRange(text.range(of: headerText)!, in: text)
        attributedText.addAttributes([.font: UIFont.boldSystemFont(ofSize: textSize)], range: headerTextRange)
        
        return attributedText
    }
}
