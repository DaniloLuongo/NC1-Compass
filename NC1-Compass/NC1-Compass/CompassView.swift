//
//  CompassView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 14/11/23.
//

import SwiftUI

struct CompassView: View {
    @EnvironmentObject var locationManager: MyLocationManager
    
    @State var showRedCircle : Bool
    
    var body: some View {
        
        Image(systemName: "arrowtriangle.up.fill")
            .foregroundStyle(.red)
            .position(x:380 ,y: 240)
        Text("N")
            .font(.system(size: 25.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees( locationManager.lastHeading?.magneticHeading ?? 0 ))
            .position(x:380 ,y: 300)
        Text("W")
            .font(.system(size: 25.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees( locationManager.lastHeading?.magneticHeading ?? 0 ))
            .position(x:300 ,y: 380)
        Text("S")
            .font(.system(size: 25.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees( locationManager.lastHeading?.magneticHeading ?? 0 ))
            .position(x:380 ,y: 460)
        Text("E")
            .font(.system(size: 25.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees( locationManager.lastHeading?.magneticHeading ?? 0 ))
            .position(x:460 ,y: 380)
        ForEach((0 ... 11), id:\.self) { i in
            Text("\(i*30)")
                .font(.system(size: 15.0))
                .foregroundStyle(.white)
                .rotationEffect(.degrees( locationManager.lastHeading?.magneticHeading ?? 0 ))
                .position(x:380+160*sin(CGFloat(Float(i*30)*Float.pi/180)), y: 380-160*cos(CGFloat(Float(i*30)*Float.pi/180)))
        }
        ForEach((0 ... 539), id:\.self) { i in
            if(i % 3 == 0)
            {
                if(i % 45 == 0)
                {
                    Circle()
                        .trim(from: CGFloat(Float(i))/540.0, to: CGFloat((Float(i+1)))/540.0)
                        .stroke(
                            .white,
                            style: StrokeStyle(
                                lineWidth: 20,
                                lineCap: .butt
                            )
                        )
                        .frame(width: 240)
                }
                else
                {
                    Circle()
                        .trim(from: CGFloat(Float(i))/540.0, to: CGFloat((Float(i+1)))/540.0)
                        .stroke(
                            .gray,
                            style: StrokeStyle(
                                lineWidth: 20,
                                lineCap: .butt
                            )
                        )
                        .frame(width: 240)
                }
            }
        }
    }
}
