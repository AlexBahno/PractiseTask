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
    // Call self.layoutIfNeeded() if your view uses auto layout
        let rect = CGSize(width: view.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17) as Any], context: nil)
        return Int(ceil(CGFloat(labelSize.height) / UIFont.systemFont(ofSize: 17).lineHeight))
  }
}
