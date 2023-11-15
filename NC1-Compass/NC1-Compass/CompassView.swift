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
        Text("0")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:380 ,y: 190)
        Text("30")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:470 ,y: 224.11)
        Text("60")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:535.88 ,y: 290)
        Text("90")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:550 ,y: 380)
        Text("120")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:535.88 ,y: 470)
        Text("150")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:470 ,y: 535.88)
        Text("180")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:380 ,y: 550)
        Text("210")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:290 ,y: 535.88)
        Text("240")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:224.11 ,y: 470)
        Text("270")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:205 ,y: 380)
        Text("300")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:224.11 ,y: 290)
        Text("330")
            .font(.system(size: 20.0))
            .foregroundStyle(.white)
            .rotationEffect(.degrees(-rotation))
            .position(x:290 ,y: 224.11)
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
    }
}
