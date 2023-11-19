//
//  MyMotionManager.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 16/11/23.
//

import SwiftUI
import CoreMotion
import AVFoundation

class MyMotionManager: NSObject ,ObservableObject {
    
    let systemSoundID: SystemSoundID = 1016
    var motionManager: CMMotionManager?
    @State var balanced = false
    var timer = Timer()
    
    override init() {
        super.init()
        motionManager = CMMotionManager()
        motionManager?.startDeviceMotionUpdates()
        motionManager?.deviceMotionUpdateInterval = 1
        
        /*timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.checkBalance()
            })*/
    }
    
    func checkBalance() {
        if UIAccessibility.isVoiceOverRunning {
            if abs(motionManager?.deviceMotion?.attitude.roll ?? 0.0) < 0.30 && abs(motionManager?.deviceMotion?.attitude.pitch ?? 0.0) < 0.30 && !balanced{
                balanced = true
                AudioServicesPlaySystemSound(systemSoundID)
                print("\(balanced)")
            }
            else {
                balanced = false
            }
        }
    }
}
