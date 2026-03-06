//
//  DriverStore.swift
//  DriverID
//
//  Created by Zihong Lin on 3/5/26.
//


import Foundation

final class DriverStore: ObservableObject {
    @Published var drivers: [Driver] = [] {
        didSet {
            save()
        }
    }
    
    private let fileName = "drivers.json"
    
    init() {
        load()
    }
    
    func addDriver(name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        drivers.append(Driver(name: trimmed))
    }
    
    func deleteDrivers(at offsets: IndexSet) {
        drivers.remove(atOffsets: offsets)
    }
    
    private func fileURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent(fileName)
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(drivers)
            try data.write(to: fileURL(), options: [.atomic])
        } catch {
            print("Failed to save drivers:", error)
        }
    }
    
    private func load() {
        let url = fileURL()
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            drivers = try JSONDecoder().decode([Driver].self, from: data)
        } catch {
            print("Failed to load drivers:", error)
        }
    }
}