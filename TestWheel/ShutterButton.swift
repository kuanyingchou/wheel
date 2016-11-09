//
//  Shutter.swift
//  TestWheel
//
//  Created by KUAN-YING CHOU on 11/9/16.
//  Copyright © 2016 KUAN-YING CHOU. All rights reserved.
//

import Foundation
import UIKit

class ShutterButton : UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.white.set()
        drawCircle(at: getObjectCenter(), radius: 35);
        drawCircle(at: getObjectCenter(), radius: 5);
    }
    
    func getObjectCenter() -> CGPoint {
        return CGPoint(
            x: self.center.x - self.frame.origin.x,
            y: self.center.y - self.frame.origin.y)
    }
}
