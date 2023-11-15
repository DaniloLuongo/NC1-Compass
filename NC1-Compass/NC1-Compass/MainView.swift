//
//  MainView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 14/11/23.
//

import SwiftUI
import CoreMotion

struct MainView: View {
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State var rotation = 20.0
    @State var xOff = -10.0
    @State var yOff = 10.0
    @State var degreeText = "0° N"
    
    var body: some View {
        ZStack {
            Color(.black)
                .scaledToFit()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
            CompassView(rotation: rotation)
                .rotationEffect(.degrees(rotation))
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
            Text(degreeText)
                .foregroundStyle(.white)
                .font(.system(size: 60))
                .position(x: 385, y: 610)
        }
        .onAppear{
            self.motionManager.startGyroUpdates(to: self.queue){ (data: CMGyroData?, error: Error?) in
                let gyro = data!.rotationRate
                
                xOff += gyro.x
                
            }
        }
    }
}

#Preview {
    MainView()
}
