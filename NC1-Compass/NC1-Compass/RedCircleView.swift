//
//  RedCircleView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 17/11/23.
//

import SwiftUI

struct RedCircleView: View {
    
    @EnvironmentObject var locationManager: MyLocationManager
    @State var valueRedCircle : Double
    
    var heading: Double {
        if (locationManager.lastHeading?.magneticHeading ?? 0) > 180.0 {
            return (locationManager.lastHeading?.magneticHeading ?? 0)/360.0 - 0.5
        }
        return (locationManager.lastHeading?.magneticHeading ?? 0)/360.0
    }
    
    var red: Double {
        if valueRedCircle > 180.0 {
            return valueRedCircle/360.0 - 0.5
        }
        return valueRedCircle/360.0
    }
    
    var body: some View {
        Text("\(Int(valueRedCircle*360))")
            .font(.system(size: 18.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees( locationManager.lastHeading?.magneticHeading ?? 0 ))
            .position(x:380+160*sin(CGFloat(Float(valueRedCircle*360)*Float.pi/180)), y: 380-160*cos(CGFloat(Float(valueRedCircle*360)*Float.pi/180)))
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
        Color(red: 0.0, green: 0.5, blue: 0.0).opacity(0.3)
        Circle()
            .trim(from: valueRedCircle < heading ? valueRedCircle : heading, to: valueRedCircle < heading ? heading : valueRedCircle)
            .stroke(
                Color(red: 1.0, green: 0.0, blue: 0.0),
                style: StrokeStyle(
                    lineWidth: 20,
                    lineCap: .butt
                )
            )
            .frame(width: 200)
            .rotationEffect(.degrees( -90 ))
    }
}
