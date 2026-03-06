//
//  DriversView.swift
//  DriverID
//
//  Created by Zihong Lin on 3/5/26.
//


import SwiftUI

struct DriversView: View {
    @ObservedObject var driverStore: DriverStore
    @State private var newDriverName: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter driver name", text: $newDriverName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Add") {
                        driverStore.addDriver(name: newDriverName)
                        newDriverName = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
                List {
                    ForEach(driverStore.drivers) { driver in
                        Text(driver.name)
                    }
                    .onDelete(perform: driverStore.deleteDrivers)
                }
            }
            .navigationTitle("Drivers")
        }
    }
}