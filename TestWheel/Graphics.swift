//
//  Graphics.swift
//  TestWheel
//
//  Created by KUAN-YING CHOU on 11/8/16.
//  Copyright © 2016 KUAN-YING CHOU. All rights reserved.
//

import Foundation
import UIKit

func drawCircle(at: CGPoint, radius: CGFloat) {
    let o = UIBezierPath()
    o.addArc(withCenter: at,
             radius: radius,
             startAngle: 0,
             endAngle: 2 * CGFloat.pi,
             clockwise: true)
    o.close()
    o.stroke()
}

func drawCross(at: CGPoint, radius: CGFloat) {
    let o = UIBezierPath()
    o.move(to: CGPoint(x: at.x-radius, y: at.y))
    o.addLine(to: CGPoint(x: at.x+radius, y: at.y))
    o.move(to: CGPoint(x: at.x, y: at.y+radius))
    o.addLine(to: CGPoint(x: at.x, y: at.y-radius))
    o.stroke()
}

func drawLine(from: CGPoint, to: CGPoint, width: CGFloat = 1) {
    let o = UIBezierPath()
    o.lineWidth = width
    o.move(to: from)
    o.addLine(to: to)
    o.stroke()
}

func drawRect(from: CGPoint, to: CGPoint) {
    drawLine(from: from, to: CGPoint(x: to.x, y: from.y))
    drawLine(from: from, to: CGPoint(x: from.x, y: to.y))
    drawLine(from: CGPoint(x: to.x, y: from.y), to: to)
    drawLine(from: CGPoint(x: from.x, y: to.y), to: to)
}

func drawText(_ text: String, at: CGPoint,
              fontName: String = "Helvetica",
              fontSize: CGFloat = 18,
              color: UIColor = UIColor.black) {
    
    let specialAttr = [
        NSFontAttributeName:
            UIFont(name: fontName, size: fontSize),
        NSForegroundColorAttributeName:
            color
    ]
    
    NSAttributedString(string: text, attributes: specialAttr).draw(
        at: at)
}
