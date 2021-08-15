//
//  ViewController.swift
//  _behavidence
//
//  Created by Dor Bismuth on 13/08/2021.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    var TouchPos : CGPoint?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager=CMMotionManager()
        manager.startGyroUpdates()
        manager.startAccelerometerUpdates()
       self.accessibilityRespondsToUserInteraction = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            if let data = manager.accelerometerData{
                let x = data.acceleration.x
                let y = data.acceleration.y
                let z = data.acceleration.z
                self.imageView.layer.contentsRect = CGRect(x: x, y: y, width: z, height: z)

            }
            
        }
        
    }
    var lastLocation = CGPoint()
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.location(in: self.view)
            self.imageView.center = CGPoint(x: (location.x - self.lastLocation.x) + self.imageView.center.x , y: (location.y - self.lastLocation.y) + self.imageView.center.y)
            lastLocation = touch.location(in: self.view)
    }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            self.lastLocation = touch.location(in: self.view)
        }
    }



}

