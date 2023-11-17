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
    @State var showRedCircle = false
    @State var valueRedCircle = 0.0
    
    var heading: Double {
        return (locationManager.lastHeading?.magneticHeading ?? 0)/360.0
    }
    
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
            Section {
                Path { path in
                    path.move(to: CGPoint(x: 380, y: 220))
                    path.addLine(to: CGPoint(x: 380, y: 270))
                }
                .stroke(
                    .white,
                    style: StrokeStyle(
                        lineWidth: 5
                    )
                )
                CompassView()
                    .rotationEffect(.degrees( -(locationManager.lastHeading?.magneticHeading ?? 0) ))
                //.animation(.easeInOut, value: -(locationManager.lastHeading?.magneticHeading ?? 0))
                    .environmentObject(locationManager)
                LevelView()
                    .position(x: 380+(motionManager.motionManager?.deviceMotion?.attitude.roll ?? 0.0)*10, y: 380+(motionManager.motionManager?.deviceMotion?.attitude.pitch ?? 0.0)*10)
                
                if showRedCircle {
                    Text("\(Int(valueRedCircle*360))")
                        .font(.system(size: 18.0))
                        .foregroundStyle(.white)
                        .rotationEffect(.degrees(-heading))
                        .position(x:380+160*sin(CGFloat(Float(valueRedCircle*360)*Float.pi/180)), y: 380-160*cos(CGFloat(Float(valueRedCircle*360)*Float.pi/180)))
                        .rotationEffect(.degrees(-valueRedCircle*360))
                    Path { path in
                        path.move(to: CGPoint(x:380+140*sin(CGFloat(Float(valueRedCircle*360)*Float.pi/180)), y: 380-140*cos(CGFloat(Float(valueRedCircle*360)*Float.pi/180))))
                        path.addLine(to: CGPoint(x:380+110*sin(CGFloat(Float(valueRedCircle*360)*Float.pi/180)), y: 380-110*cos(CGFloat(Float(valueRedCircle*360)*Float.pi/180))))
                    }
                    .stroke(
                        .white,
                        style: StrokeStyle(
                            lineWidth: 2
                        )
                    )
                    .rotationEffect(.degrees(-(locationManager.lastHeading?.magneticHeading ?? 0)), anchor: UnitPoint(x: 0.5, y:0.5))
                    if heading > valueRedCircle + 0.5 {
                        Circle()
                            .trim(from: valueRedCircle, to: 1-heading+2*valueRedCircle)
                            .stroke(
                                Color(red: 1.0, green: 0.0, blue: 0.0),
                                style: StrokeStyle(
                                    lineWidth: 20,
                                    lineCap: .butt
                                )
                            )
                            .frame(width: 200)
                            .rotationEffect(.degrees( -valueRedCircle*360-90 ))
                    }
                    else {
                        Circle()
                            .trim(from: valueRedCircle, to: heading)
                            .stroke(
                                Color(red: 1.0, green: 0.0, blue: 0.0),
                                style: StrokeStyle(
                                    lineWidth: 20,
                                    lineCap: .butt
                                )
                            )
                            .frame(width: 200)
                            .rotationEffect(.degrees( -(locationManager.lastHeading?.magneticHeading ?? 0) - 90 ))
                    }
                }
                
                Path { path in
                    path.move(to: CGPoint(x: 380, y: 315))
                    path.addLine(to: CGPoint(x: 380, y: 445))
                }
                .stroke(.gray)
                Path { path in
                    path.move(to: CGPoint(x: 315, y: 380))
                    path.addLine(to: CGPoint(x: 445, y: 380))
                }
                .stroke(.gray)
            }
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    
                }
                .onEnded { value in
                    showRedCircle = !showRedCircle
                    valueRedCircle = heading
                })
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
                .position(x: 385, y: 695)
            Text("\(placemark)")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .position(x: 385, y: 720)
        }
    }
}
