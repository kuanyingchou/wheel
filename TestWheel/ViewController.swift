//
//  ViewController.swift
//  TestWheel
//
//  Created by KUAN-YING CHOU on 11/5/16.
//  Copyright © 2016 KUAN-YING CHOU. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var exposureCompensationView: WheelView!
    @IBOutlet weak var shutterSpeedView: WheelView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exposureCompensationView.values = [
            (-3, "-3"),
            (-2, "-2"),
            (-1, "-1"),
            (0, "0"),
            (1, "+1"),
            (2, "+2"),
            (3, "+3")
        ]
        exposureCompensationView.startAngle = -CGFloat.pi / 4 * 3
        exposureCompensationView.step = 3
        exposureCompensationView.labelSize = 18
        exposureCompensationView.startIndex = 3
        exposureCompensationView.span = 2*CGFloat.pi - CGFloat.pi / 3
        
        shutterSpeedView.values = [
            (0, "A"),
            (1, "1"),
            (2, "2"),
            (4, "4"),
            (8, "8"),
            (16, "15"),
            (32, "30"),
            (64, "60"),
            (128, "120"),
            (256, "250"),
            (512, "500"),
            (1024, "1000"),
            (2048, "2000"),
            (4096, "4000"),
            (8192, "8000"),
        ]
        shutterSpeedView.step = 3
        shutterSpeedView.startAngle = -CGFloat.pi / 4
        shutterSpeedView.startIndex = 0
        shutterSpeedView.labelSize = 12
        shutterSpeedView.span = 2*CGFloat.pi - CGFloat.pi / 6
        shutterSpeedView.isSmallScaleVisible = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    class Recognizer : UIGestureRecognizer {
        
    }
    let recognizer = Recognizer()
}

