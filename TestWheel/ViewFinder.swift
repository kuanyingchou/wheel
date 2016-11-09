//
//  ViewFinder.swift
//  TestWheel
//
//  Created by KUAN-YING CHOU on 11/9/16.
//  Copyright © 2016 KUAN-YING CHOU. All rights reserved.
//

import Foundation
import UIKit

class ViewFinder : UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.white.set()
        drawRect(from: CGPoint.zero,
                 to: CGPoint(x: self.frame.width, y: self.frame.height))
    }
}
