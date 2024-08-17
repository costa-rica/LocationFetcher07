//
//  LocationFetcher.swift
//  LocationFetcher05
//
//  Created by Nick Rodriguez on 17/08/2024.
//

import Foundation
import CoreLocation


class LocationFetcher: NSObject, CLLocationManagerDelegate {
    static let shared = LocationFetcher()
    let locationManager = CLLocationManager()
    var updateStatus: ((Int) -> Void)?
    var arryUserLocation:[UserLocation]!
    var userLocationManagerAuthStatus: String? {
        didSet {
            // Update UserDefaults value when property value changes
            UserDefaults.standard.set(userLocationManagerAuthStatus, forKey: "userLocationManagerAuthStatus")
        }
    }
    override init(){
        super.init()
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startMonitoringSignificantLocationChanges()
//        locationManager.startUpdatingLocation()
//        locationManager.requestLocation()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        loadUserLocation()
        loadUserLocationManagerAuthStatus()
    }

    func loadUserLocation() {
        arryUserLocation = []
        if let encodedData = UserDefaults.standard.data(forKey: "arryUserLocation") {
            do {
                let decodedArray = try JSONDecoder().decode([UserLocation].self, from: encodedData)
                arryUserLocation = decodedArray
            } catch {
                print("*** (1) This should occur on first Launch: \(error) ***")
            }
        }
    }
    func saveUserLocation() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arryUserLocation) {
            UserDefaults.standard.set(encoded, forKey: "arryUserLocation")
        } else {
            print("!!! (1) This should NEVER occur: failed to save to UserDefaults !!!")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        let userLocation = UserLocation()
        userLocation.latitude = lastLocation.coordinate.latitude
        userLocation.longitude = lastLocation.coordinate.longitude
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd-HHmm"
        userLocation.timestampString = dateFormatter.string(from: userLocation.timestamp)
        arryUserLocation.append(userLocation)
        saveUserLocation()
        updateStatus?(arryUserLocation.count)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
        case .notDetermined:
            self.userLocationManagerAuthStatus = "notDetermined"
        case .restricted:
            self.userLocationManagerAuthStatus = "restricted"
        case .denied:
            self.userLocationManagerAuthStatus = "denied"
        case .authorizedAlways:
            self.userLocationManagerAuthStatus = "authorizedAlways"
        case .authorizedWhenInUse:
            self.userLocationManagerAuthStatus = "authorizedWhenInUse"
        @unknown default:
            self.userLocationManagerAuthStatus = "unknown"
        }
    }
    func loadUserLocationManagerAuthStatus() {
        // Search for UserDefaults value and populate property
        userLocationManagerAuthStatus = UserDefaults.standard.string(forKey: "userLocationManagerAuthStatus")
    }
    
}

class UserLocation: Codable {
    var timestamp: Date = Date()
    var timestampString: String!
    var latitude: Double!
    var longitude: Double!
    var appState: String?
}

enum LocationFetcherError:Error{
    case failedDecode
    case somethingWentWrong
    var localizedDescription:String{
        switch self{
        case.failedDecode: return "Failed to decode"
        default:return "uhhh Idk?"
        }
    }
}

