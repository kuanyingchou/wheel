//
//  WheelView.swift
//  TestWheel
//
//  Created by KUAN-YING CHOU on 11/5/16.
//  Copyright © 2016 KUAN-YING CHOU. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class WheelView : UIView {
    
    var radius : CGFloat = 80
    var rotation : CGFloat = 0
    var adjustedRotation : CGFloat = 0
    
//    var center: CGPoint {
//        get {
//            return CGPoint(x: frame.width/2, y: frame.height/2)
//        }
//    }
    var generator = UISelectionFeedbackGenerator()
    
    var touches : [UITouch] = []
    
    let outlineColor = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        myInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        myInit()
    }
    
    func myInit() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tap.numberOfTapsRequired = 2;
        
        self.addGestureRecognizer(tap)
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
//        
//        let touchsBeganStream = self.rx.sentMessage(#selector(self.touchesBegan(_:with:)))
//        let touchesMovedStream =
//            self.rx.sendMessage(#selector(self.touchesMoved(_:with:)))
//        let touchesEndedStream =
//            self.rx.sendMessage(#selector(self.touchesEnded(_:with:)))
//        let touchesCanceledStream =
//            self.rx.sendMessage(#selector(self.touchesCancelled(_:with:)))
//        
//        let touchesEndedOrCanceledStream =
//            touchesEndedStream.merge(touchesCanceledStream)
        
        
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        rotation = 0
        self.touches.removeAll()
        redraw()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("touch began")
        
        for t in touches {
            if(containsTouch(t)) {
                // what!?
            } else {
                let center = getObjectCenter()
                if t.location(in: self).dist(center) <= radius * 1.5 {
                    self.touches.append(t)
                }
            }
        }
        
        if self.touches.count > 0 {
            generator.prepare()
        }
        
        
        redraw()
    }
    
    private func containsTouch(_ t : UITouch) -> Bool {
        for o in self.touches {
            if o == t {
                return true
            }
        }
        return false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if self.touches.count <= 0 {
            return
        }
        
        if touches.index(of: self.touches.first!) == nil {
            return
        }
        
        // print("touch moved")
        let t = self.touches.first!
        let curr = t.location(in: self)
        let last = t.previousLocation(in: self)
        
        let center = getObjectCenter()
        let oldAngle = atan2(last.y - center.y, last.x - center.x)
        let newAngle = atan2(curr.y - center.y, curr.x - center.x)
        rotate(newAngle-oldAngle)
        // let dist = curr.dist(center)
        
        // print(dist)
        redraw()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with    event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        touchesEndedOrCancelled(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesCancelled(touches, with: event)
        touchesEndedOrCancelled(touches, with: event)
    }
    
    func touchesEndedOrCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.touches.count <= 0 {
            return
        }
        
        let oldFirst = self.touches.first!
        
        for t in touches {
            let i = self.touches.index(of: t)
            if i != nil {
                self.touches.remove(at: i!)
            }
        }
        
        redraw()
        
        if self.touches.count <= 0 {
            return
        }
        
        // touchBegan?
        
        print("touch ended")
    }
    
    func redraw() {
        self.setNeedsDisplay()
    }
    
    func getObjectCenter() -> CGPoint {
        return CGPoint(
            x: self.center.x - self.frame.origin.x,
            y: self.center.y - self.frame.origin.y)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        UIColor.red.set()
        
        let center = getObjectCenter()
        
//        drawCircle(at: center, radius: self.frame.width/2)
//        drawCircle(at: center, radius: self.frame.width)
        
        outlineColor.set()
        
        drawCircle(at: center, radius: radius)
        drawCircle(at: center, radius: radius / 8)
        
//        if self.touches.count > 0 {
//            let first = self.touches.first!
//            UIColor.green.set()
//            drawCircle(at: first.location(in: self), radius: 20)
//            UIColor.blue.set()
//            for i in stride(from: 1, to: self.touches.count, by: 1) {
//                drawCircle(at: self.touches[i].location(in: self), radius: 20)
//            }
//            
//        }
        
        // drawRect(from: CGPoint.zero,
        //         to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.translateBy(x: center.x, y: center.y)
        
        //// cross at center
        // UIColor.red.set()
        // drawCross(at: CGPoint.zero, radius: 20)
        
        // indicator
        outlineColor.set()
        drawLine(
            from: CGPoint(x: -radius - 20, y: 0),
            to: CGPoint(x: -radius - 10, y:0))
        
        let rot = round(self.rotation / stepAngle) * stepAngle
        if rot != adjustedRotation {
            print("!! \(self.rotation)")
            AudioServicesPlaySystemSound (1306)
            generator.selectionChanged()
        } else {
            print("-- \(self.rotation)")
            
        }
        context.rotate(by: rot)
        
        adjustedRotation = rot
        
        var angle : CGFloat = 0
        var count = 0
        let decoRim = UIBezierPath()
        decoRim.move(to: CGPoint(x: radius+3, y: 0))
        // decoRim.addLine(to: CGPoint(x: 100, y: 0))
        
        for _ in 1...80 {
            var r : CGFloat = radius+3
            angle += CGFloat.pi / 40 - CGFloat.pi / 150
            decoRim.addLine(to: CGPoint(x: r * cos(angle), y: r * sin(angle)))
            r = radius+6
            angle += CGFloat.pi / 150
            decoRim.addLine(to: CGPoint(x: r * cos(angle), y: r * sin(angle)))
            
            angle += CGFloat.pi / 40 - CGFloat.pi / 150
            decoRim.addLine(to: CGPoint(x: r * cos(angle), y: r * sin(angle)))
            angle += CGFloat.pi / 150
            r = radius+3
            decoRim.addLine(to: CGPoint(x: r * cos(angle), y: r * sin(angle)))
            count += 1
        }
//        while angle < 2 * CGFloat.pi {
//            angle += CGFloat.pi / 10
//            // let r : CGFloat = count%2==0 ? 85 : 80
//            let r : CGFloat = 85
//            decoRim.addLine(to: CGPoint(x: cos(r), y: sin(r)))
//            count += 1
//        }
        decoRim.close()
        decoRim.stroke()
        
        let segBegin = radius-8
        let segEnd = radius-5
        let lineWidth : CGFloat = 1;
        let textYOffset : CGFloat = -11
        
        
        
        // first seg
        drawLine(
            from: CGPoint(x: -segBegin, y: 0),
            to: CGPoint(x: -segEnd, y: 0),
            width: lineWidth)
        
        outlineColor.set()
        drawText("0", at: CGPoint(x: -radius*0.8, y: textYOffset), color: outlineColor)
        
        context.saveGState()
        for i in 0..<3 {
            for _ in 0..<3 {
                context.rotate(by: CGFloat.pi / 11)
                let scale = UIBezierPath()
                scale.move(to: CGPoint(x: -segBegin, y: 0))
                scale.addLine(to: CGPoint(x: -segEnd, y: 0))
                scale.lineWidth = lineWidth
                scale.stroke()
                
            }
            drawText("+ \(i+1)",
                at: CGPoint(x: -radius * 0.8, y: textYOffset), color: outlineColor)
        }
        
        context.restoreGState()
        context.saveGState()
        for i in 0..<3 {
            for _ in 0..<3 {
                context.rotate(by: CGFloat.pi / -11)
                let scale = UIBezierPath()
                scale.move(to: CGPoint(x: -segBegin, y: 0))
                scale.addLine(to: CGPoint(x: -segEnd, y: 0))
                scale.lineWidth = lineWidth
                scale.stroke()
                
            }
            drawText("- \(i+1)", at: CGPoint(x: -radius * 0.8, y: textYOffset), color: outlineColor)
        }
        context.restoreGState()
        
    }
    
    let stepAngle = CGFloat.pi / 11
    
    func rotate(_ angle: CGFloat) {
        // print("rotate \(angle)")
        self.rotation += angle
        redraw()
    }
}

extension CGPoint {
    public func dist(_ that: CGPoint) -> CGFloat {
        return hypot(x - that.x, y - that.y)
    }
}
