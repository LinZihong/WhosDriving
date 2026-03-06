//
//  ContentView.swift
//  DriverID
//
//  Created by Zihong Lin on 2/28/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var motion = MotionManager()
    @State private var isRunning = false
        
    var body: some View {
        VStack(spacing: 25) {
            
            Text("Driver Motion Monitor")
                .font(.title)
            
            VStack(spacing: 12) {
                
                Text("Acceleration (g)")
                    .font(.headline)
                
                Text("X: \(motion.accelX, specifier: "%.3f")")
                Text("Y: \(motion.accelY, specifier: "%.3f")")
                Text("Z: \(motion.accelZ, specifier: "%.3f")")
                
                Divider().padding(.vertical, 8)
                
                Text("Gyroscope (rad/s)")
                    .font(.headline)
                
                Text("X: \(motion.gyroX, specifier: "%.3f")")
                Text("Y: \(motion.gyroY, specifier: "%.3f")")
                Text("Z: \(motion.gyroZ, specifier: "%.3f")")
                
            }
            .font(.system(size: 20, weight: .medium, design: .monospaced))
            
            Button(isRunning ? "Stop Recording" : "Start Recording") {
                if isRunning {
                    motion.stop()
                } else {
                    motion.start()
                }
                isRunning.toggle()
            }
            .buttonStyle(.borderedProminent)
            .tint(isRunning ? .red : .green)
            .controlSize(.large)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
