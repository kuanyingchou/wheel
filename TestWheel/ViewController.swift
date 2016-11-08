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

    @IBOutlet var wheelView: WheelView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    class Recognizer : UIGestureRecognizer {
        
    }
    let recognizer = Recognizer()
}

