//
//  Extensions.swift
//  PractiseTask
//
//  Created by Alexandr Bahno on 05.10.2023.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
}

extension String {
    func countLines(_ view: UIView) -> Int {
    guard let myText = self as NSString? else {
      return 0
    }
        let rect = CGSize(width: view.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17) as Any], context: nil)
        return Int(ceil(CGFloat(labelSize.height) / UIFont.systemFont(ofSize: 17).lineHeight))
  }
}

extension Int {
    static func daysBetween(start: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: Date()).day!
    }
}

extension UIColor {
    static let title = UIColor(red: 71/255, green: 82/255, blue: 94/255, alpha: 1)
    
    static let text = UIColor(red: 133/255, green: 148/255, blue: 168/255, alpha: 1)
    
    static let buttonBackground = UIColor(red: 71/255, green: 82/255, blue: 94/255, alpha: 1)
}
