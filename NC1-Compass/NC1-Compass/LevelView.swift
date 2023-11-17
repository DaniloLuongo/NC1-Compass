//
//  LevelView.swift
//  NC1-Compass
//
//  Created by Danilo Luongo on 15/11/23.
//

import SwiftUI

struct LevelView: View {
    
    var body: some View {
        Circle()
            .foregroundStyle(.gray.opacity(0.33))
            .frame(height: 80)
        Path { path in
            path.move(to: CGPoint(x: 380, y: 370))
            path.addLine(to: CGPoint(x: 380, y: 390))
        }
        .stroke(.gray)
        Path { path in
            path.move(to: CGPoint(x: 370, y: 380))
            path.addLine(to: CGPoint(x: 390, y: 380))
        }
        .stroke(.gray)
    }
}
