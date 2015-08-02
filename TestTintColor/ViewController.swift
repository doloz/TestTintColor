//
//  ViewController.swift
//  TestTintColor
//
//  Created by Alex on 01.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {
    let manager = CMMotionManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        var image = UIImage(named: "loving4")
        image = image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imageView.image = image
        manager.gyroUpdateInterval = 1
        manager.deviceMotionUpdateInterval = 1.0 / 25
        let queue = NSOperationQueue()
    
        manager.startDeviceMotionUpdatesToQueue(queue, withHandler: {
                deviceMotion, error in
                let attitude = deviceMotion.attitude
                println("Rotation: \(attitude.roll), \(attitude.pitch), \(attitude.yaw)")
                let q = attitude.quaternion
                println("Quaternion: \(q.x), \(q.y), \(q.z), \(q.w)")
                func mapTo01(x: Double) -> CGFloat {
                    return CGFloat(x / (2*M_PI) + 0.5)
                }
                let r = mapTo01(attitude.roll)
                let g = mapTo01(attitude.pitch)
                let b = mapTo01(attitude.yaw)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.view.window!.tintColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
                })
            
            }
        )
    }

    @IBOutlet weak var imageView: UIImageView!
}

