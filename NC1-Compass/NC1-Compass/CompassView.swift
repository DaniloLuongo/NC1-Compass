//
//  CompassView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 14/11/23.
//

import SwiftUI

struct CompassView: View {
    @State var rotation : Double
    var body: some View {
        Image(systemName: "arrowtriangle.up.fill")
            .foregroundStyle(.red)
            .position(x:380 ,y: 220)
        Text("N")
            .font(.system(size: 30.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:380 ,y: 300)
        Text("W")
            .font(.system(size: 30.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:300 ,y: 380)
        Text("S")
            .font(.system(size: 30.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:380 ,y: 460)
        Text("E")
            .font(.system(size: 30.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:460 ,y: 380)
        ForEach((0 ... 359), id:\.self) { i in
            if(i % 3 == 0)
            {
                if(i % 30 == 0)
                {
                    Circle()
                        .trim(from: CGFloat(Float(i))/360.0, to: CGFloat((Float(i+1)))/360.0)
                        .stroke(
                            .white,
                            style: StrokeStyle(
                                lineWidth: 30,
                                lineCap: .butt
                            )
                        )
                        .frame(width: 260)
                }
                else
                {
                    Circle()
                        .trim(from: CGFloat(Float(i))/360.0, to: CGFloat((Float(i+1)))/360.0)
                        .stroke(
                            .white,
                            style: StrokeStyle(
                                lineWidth: 20,
                                lineCap: .butt
                            )
                        )
                        .frame(width: 250)
                }
            }
        }
        /*ForEach((0 ... 359), id:\.self) { i in
            if(i % 3 == 0)
            {
                if(i % 30 == 0)
                {
                    Circle()
                        .trim(from: CGFloat(Float(i-1))/360.0, to: CGFloat((Float(i)))/360.0)
                        .stroke(
                            .white,
                            style: StrokeStyle(
                                lineWidth: 20,
                                lineCap: .butt
                            )
                        )
                        .frame(width: 250)
                }
                Circle()
                    .trim(from: CGFloat(Float(i))/360.0, to: CGFloat((Float(i+1)))/360.0)
                    .stroke(
                        .white,
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .butt
                        )
                    )
                    .frame(width: 250)
            }
        }*/
    }
}
