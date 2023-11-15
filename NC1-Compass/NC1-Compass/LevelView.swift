//
//  LevelView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 15/11/23.
//

import SwiftUI

struct LevelView: View {
    
    @State var xOff : Double
    @State var yOff : Double
    
    var body: some View {
        Circle()
            .foregroundStyle(.gray.opacity(0.33))
            .frame(height: 80)
            .position(x: 380+xOff, y: 380+yOff)
        Path { path in
            path.move(to: CGPoint(x: 380+xOff, y: 365+yOff))
            path.addLine(to: CGPoint(x: 380+xOff, y: 395+yOff))
        }
        .stroke(.white)
        Path { path in
            path.move(to: CGPoint(x: 365+xOff, y: 380+yOff))
            path.addLine(to: CGPoint(x: 395+xOff, y: 380+yOff))
        }
        .stroke(.white)
    }
}
