//
//  MotionManager.swift
//  DriverID
//
//  Created by Zihong Lin on 2/28/26.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    
    private let motionManager = CMMotionManager()
    
    // Acceleration (gravity removed)
    @Published var accelX: Double = 0
    @Published var accelY: Double = 0
    @Published var accelZ: Double = 0
    
    // Gyroscope (rotation rate)
    @Published var gyroX: Double = 0
    @Published var gyroY: Double = 0
    @Published var gyroZ: Double = 0
    
    func start() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion not available")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 30.0
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let data = data else { return }
            
            let accel = data.userAcceleration
            let gyro = data.rotationRate
            
            self?.accelX = accel.x
            self?.accelY = accel.y
            self?.accelZ = accel.z
            
            self?.gyroX = gyro.x
            self?.gyroY = gyro.y
            self?.gyroZ = gyro.z
        }
    }
    
    func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
}
