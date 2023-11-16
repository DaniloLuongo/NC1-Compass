//
//  MyMotionManager.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 16/11/23.
//

import SwiftUI
import CoreMotion

class MyMotionManager: NSObject ,ObservableObject {
    
    var motionManager: CMMotionManager?
    
    override init() {
        super.init()
        motionManager = CMMotionManager()
        motionManager?.startDeviceMotionUpdates()
        motionManager?.deviceMotionUpdateInterval = 0.5
    }
}
