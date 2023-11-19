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
    
    var headingTrimValue: Double {
        return (locationManager.lastHeading?.magneticHeading ?? 0)/360.0
    }
    
    var body: some View {
        Text("\(Int(valueRedCircle*360))")
            .font(.system(size: 18.0))
            .bold()
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
        if headingTrimValue - valueRedCircle > 0.5 || valueRedCircle - headingTrimValue > 0.5 {
            Circle()
                .stroke(
                    Color(red: 1.0, green: 0.0, blue: 0.0),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .butt
                    )
                )
                .frame(width: 200)
            Circle()
                .trim(from: valueRedCircle < headingTrimValue ? valueRedCircle : headingTrimValue, to: valueRedCircle < headingTrimValue ? headingTrimValue : valueRedCircle)
                .stroke(
                    Color(red: 0.0, green: 0.0, blue: 0.0),
                    style: StrokeStyle(
                        lineWidth: 21,
                        lineCap: .butt
                    )
                )
                .frame(width: 200)
                .rotationEffect(.degrees( valueRedCircle - 90 ))
        }
        else {
            Circle()
                .trim(from: valueRedCircle < headingTrimValue ? valueRedCircle : headingTrimValue, to: valueRedCircle < headingTrimValue ? headingTrimValue : valueRedCircle)
                .stroke(
                    Color(red: 1.0, green: 0.0, blue: 0.0),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .butt
                    )
                )
                .frame(width: 200)
                .rotationEffect(.degrees( valueRedCircle - 90 ))
        }
        
    }
}
