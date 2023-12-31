//
//  MyLocationManager.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 15/11/23.
//

import SwiftUI
import CoreLocation

class MyLocationManager : NSObject ,ObservableObject, CLLocationManagerDelegate {
    
    var timer = Timer()
    var initialGeocodeDone = false
    
    private let geocoder = CLGeocoder()
    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
      }
    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
      }
    
    private var locationManager: CLLocationManager?
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var lastHeading: CLHeading?


    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.startUpdatingHeading()
        
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { _ in
            self.geocode()
            })
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        print(#function, statusString)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        if !initialGeocodeDone {
            geocode()
            initialGeocodeDone = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        lastHeading = newHeading
    }
    
    private func geocode() {
        guard let location = lastLocation else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
          if error == nil {
            self.placemark = places?[0]
          } else {
            self.placemark = nil
          }
        })
      }
}
