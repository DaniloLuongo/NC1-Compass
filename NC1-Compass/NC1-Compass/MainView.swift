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
            CompassView(rotation: rotation)
                .rotationEffect(.degrees(rotation))
        }
    }
}

#Preview {
    MainView()
}
