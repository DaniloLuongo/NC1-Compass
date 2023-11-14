//
//  MainView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 14/11/23.
//

import SwiftUI

struct MainView: View {
    
    @State var rotation = 0.0
    
    var body: some View {
        ZStack {
            Color(.black)
                .scaledToFit()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
            ForEach((0 ... 359), id:\.self) { i in
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
                            .rotationEffect(.degrees(rotation))
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
                        .rotationEffect(.degrees(rotation))
                        .frame(width: 250)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
