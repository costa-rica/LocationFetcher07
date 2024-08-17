//
//  AppStateMonitor.swift
//  LocationFetcher07
//
//  Created by Nick Rodriguez on 17/08/2024.
//

import Foundation

// Define the AppState class
class AppState:Codable {
    let timestamp: Date
    let state: String
    
    init(state: String) {
        self.timestamp = Date()  // Initialize timestamp to the current date and time
        self.state = state
    }
}

// Define the AppStateMonitor singleton class
class AppStateMonitor {
    
    // Singleton instance
    static let shared = AppStateMonitor()
    
    // Array to store app states
    private(set) var arryAppState: [AppState] = []{
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(arryAppState) {
                UserDefaults.standard.set(encoded, forKey: "arryAppState")
            } else {
                print("failed to set the arryAppState UserDefaults")
            }
        }
    }
    
    // Private initializer to prevent external instantiation
    private init() {
        loadArryAppStateFromUserDefaults()
    }
    
    // Method to track the app state
    func trackAppStateChange(to newState: String) {
        let appState = AppState(state: newState)
        arryAppState.append(appState)
        print("App state changed to: \(newState) at \(appState.timestamp)")
    }
    func loadArryAppStateFromUserDefaults() {
        if let encodedData = UserDefaults.standard.data(forKey: "arryAppState") {
            do {
                let decodedArray = try JSONDecoder().decode([AppState].self, from: encodedData)
                arryAppState = decodedArray
            } catch {
                print("Failed to decode AppState array: \(error)")
            }
        }
    }
    
    // Optional: Method to print all recorded states
    func printAllAppStates() {
        for appState in arryAppState {
            print("State: \(appState.state), Timestamp: \(appState.timestamp)")
        }
    }
}
