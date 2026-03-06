//
//  ContentView.swift
//  DriverID
//
//  Created by Zihong Lin on 3/5/26.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var motion = MotionManager()
    @StateObject private var driverStore = DriverStore()
    
    var body: some View {
        TabView {
            RecordView(motion: motion, driverStore: driverStore)
                .tabItem {
                    Label("Record", systemImage: "waveform.path")
                }
            
            DriversView(driverStore: driverStore)
                .tabItem {
                    Label("Drivers", systemImage: "person.2")
                }
            
            SensorView(motion: motion)
                .tabItem {
                    Label("Sensor", systemImage: "gyroscope")
                }
        }
    }
}

#Preview {
    ContentView()
}
