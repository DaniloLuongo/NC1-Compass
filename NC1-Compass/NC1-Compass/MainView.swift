//
//  MainView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 14/11/23.
//

import SwiftUI
import CoreLocation
import CoreMotion

struct MainView: View {
    
    @StateObject var locationManager = MyLocationManager()
    @StateObject var motionManager = MyMotionManager()
    @State var xOff = 0.0
    @State var yOff = 0.0
    
    var dmsLatitude: (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int((locationManager.lastLocation?.coordinate.latitude ?? 0) * 3600)
        let degrees = seconds / 3600
        seconds = abs(seconds % 3600)
        return (degrees, seconds / 60, seconds % 60)
    }
    
    var dmsLongitude: (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int((locationManager.lastLocation?.coordinate.longitude ?? 0) * 3600)
        let degrees = seconds / 3600
        seconds = abs(seconds % 3600)
        return (degrees, seconds / 60, seconds % 60)
    }
    
    var placemark: String {
        return("\(locationManager.placemark?.locality ?? "---"), \(locationManager.placemark?.administrativeArea ?? "---")")
    }
    
    /*var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
        
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }*/
    
    var userHeading: String {
        return "\(Int(locationManager.lastHeading?.magneticHeading ?? 0))"
    }
    var direction: String {
        if (locationManager.lastHeading?.magneticHeading ?? 0) > 337.5 || (locationManager.lastHeading?.magneticHeading ?? 0) <= 22.5 {
            return "N"
        }
        else if (locationManager.lastHeading?.magneticHeading ?? 0) > 22.5 && (locationManager.lastHeading?.magneticHeading ?? 0) <= 67.5 {
            return "NE"
        }
        else if (locationManager.lastHeading?.magneticHeading ?? 0) > 67.5 && (locationManager.lastHeading?.magneticHeading ?? 0) <= 112.5 {
            return "E"
        }
        else if (locationManager.lastHeading?.magneticHeading ?? 0) > 112.5 && (locationManager.lastHeading?.magneticHeading ?? 0) <= 157.5 {
            return "SE"
        }
        else if (locationManager.lastHeading?.magneticHeading ?? 0) > 157.5 && (locationManager.lastHeading?.magneticHeading ?? 0) <= 202.5 {
            return "S"
        }
        else if (locationManager.lastHeading?.magneticHeading ?? 0) > 202.5 && (locationManager.lastHeading?.magneticHeading ?? 0) <= 247.5 {
            return "SW"
        }
        else if (locationManager.lastHeading?.magneticHeading ?? 0) > 247.5 && (locationManager.lastHeading?.magneticHeading ?? 0) <= 292.5 {
            return "W"
        }
        else
        {
            return "NW"
        }
    }
    
    var body: some View {
        ZStack {
            Color(.black)
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            CompassView()
                .rotationEffect(.degrees( -(locationManager.lastHeading?.magneticHeading ?? 0) ))
                //.animation(.easeInOut, value: -(locationManager.lastHeading?.magneticHeading ?? 0))
                .environmentObject(locationManager)
            LevelView()
                .position(x: 380+(motionManager.motionManager?.deviceMotion?.attitude.roll ?? 0.0)*10, y: 380+(motionManager.motionManager?.deviceMotion?.attitude.pitch ?? 0.0)*10)
            Path { path in
                path.move(to: CGPoint(x: 380, y: 320))
                path.addLine(to: CGPoint(x: 380, y: 440))
            }
            .stroke(.white)
            Path { path in
                path.move(to: CGPoint(x: 320, y: 380))
                path.addLine(to: CGPoint(x: 440, y: 380))
            }
            .stroke(.white)
            Path { path in
                path.move(to: CGPoint(x: 380, y: 195))
                path.addLine(to: CGPoint(x: 380, y: 265))
            }
            .stroke(
                .white,
                style: StrokeStyle(
                    lineWidth: 5
                )
            )
            Text("\(userHeading)° \(direction)")
                .foregroundStyle(.white)
                .font(.system(size: 60))
                .position(x: 385, y: 610)
                .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: locationManager.lastHeading?.magneticHeading ?? 0) { oldValue, newValue in
                    Int(newValue) % 30 == 0
                }
            Text(String(format: "%d°%d'%d\" %@   %d°%d'%d\" %@", abs(dmsLatitude.degrees), dmsLatitude.minutes, dmsLatitude.seconds, dmsLatitude.degrees >= 0 ? "N" : "S", abs(dmsLongitude.degrees), dmsLongitude.minutes, dmsLongitude.seconds, dmsLongitude.degrees >= 0 ? "E" : "W"))
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .position(x: 385, y: 670)
            Text("\(Int(locationManager.lastLocation?.altitude ?? 0))m Elevation")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .position(x: 385, y: 690)
            Text("\(placemark)")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .position(x: 385, y: 710)
        }
    }
}
