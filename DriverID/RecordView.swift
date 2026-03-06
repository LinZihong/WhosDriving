//
//  RecordView.swift
//  DriverID
//
//  Created by Zihong Lin on 3/5/26.
//


import SwiftUI

struct RecordView: View {
    @ObservedObject var motion: MotionManager
    @ObservedObject var driverStore: DriverStore
    
    @State private var isRunning = false
    @State private var selectedDriverID: UUID?
    
    var selectedDriverName: String {
        guard let id = selectedDriverID,
              let driver = driverStore.drivers.first(where: { $0.id == id }) else {
            return "No driver selected"
        }
        return driver.name
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                if driverStore.drivers.isEmpty {
                    Text("No drivers yet. Add one in the Drivers tab.")
                        .foregroundStyle(.secondary)
                } else {
                    Picker("Driver", selection: $selectedDriverID) {
                        Text("Select a driver").tag(UUID?.none)
                        ForEach(driverStore.drivers) { driver in
                            Text(driver.name).tag(Optional(driver.id))
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Text("Selected: \(selectedDriverName)")
                    .font(.headline)
                
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
                
                Button {
                    if isRunning {
                        motion.stop()
                    } else {
                        motion.start()
                    }
                    isRunning.toggle()
                } label: {
                    Text(isRunning ? "Stop Recording" : "Start Recording")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(isRunning ? .red : .green)
                .controlSize(.large)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Record")
        }
    }
}