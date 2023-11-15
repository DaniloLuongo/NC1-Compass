//
//  MainView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 14/11/23.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    
    @StateObject var locationManager = MyLocationManager()
    
    //@State var rotation = 0.0
    @State var xOff = 0.0
    @State var yOff = 0.0
    //@State var degreeText = "0° N"
    
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
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
            CompassView()
                .rotationEffect(.degrees( -(locationManager.lastHeading?.magneticHeading ?? 0) ))
                .environmentObject(locationManager)
            LevelView(xOff: xOff, yOff: yOff)
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
            Circle()
                .trim(from: 0.0, to: 2/360)
                .stroke(
                    .white,
                    style: StrokeStyle(
                        lineWidth: 80,
                        lineCap: .butt
                    )
                )
                .frame(width: 320)
                .rotationEffect(.degrees(-91))
            Text("\(userHeading)° \(direction)")
                .foregroundStyle(.white)
                .font(.system(size: 60))
                .position(x: 385, y: 610)
        }
    }
}
