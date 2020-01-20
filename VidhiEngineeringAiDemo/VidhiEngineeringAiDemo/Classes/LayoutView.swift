//
//  LayoutView.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 20/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LayoutView : UIView {
    @IBInspectable var corderRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.corderRadius
            self.clipsToBounds = self.corderRadius > 0
        }
    }
}


