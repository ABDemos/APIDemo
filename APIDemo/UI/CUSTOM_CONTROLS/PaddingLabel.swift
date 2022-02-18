//
//  PaddingLabel.swift
//  APIDemo
//
//  Created by Adam Beaumont on 18/02/2022.
//

import UIKit

// Subclass of UILabel to add some padding to the start of the line
// This means you don't need to back a label with an extra view to get boxed out text
class PaddingLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
