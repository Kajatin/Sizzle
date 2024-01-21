//
//  EmojiBackground.swift
//  Sizzle
//
//  Created by Roland Kajatin on 26/11/2023.
//

import SwiftUI
import GameplayKit

struct EmojiBackground: View {
    let emojis = ["🍎", "🍓", "🍍", "🥝", "🍔", "🍩", "🍽️", "🍤", "🍰", "🥦", "🌽", "🍉"]
    let positions = [
        CGPoint(x: 0.08, y: 0.06),
        CGPoint(x: 0.06, y: 0.29),
        CGPoint(x: 0.1, y: 0.51),
        CGPoint(x: 0.07, y: 0.72),
        CGPoint(x: 0.08, y: 0.89),
        CGPoint(x: 0.28, y: 0.07),
        CGPoint(x: 0.32, y: 0.25),
        CGPoint(x: 0.37, y: 0.49),
        CGPoint(x: 0.37, y: 0.76),
        CGPoint(x: 0.28, y: 0.92),
        CGPoint(x: 0.69, y: 0.06),
        CGPoint(x: 0.63, y: 0.21),
        CGPoint(x: 0.71, y: 0.52),
        CGPoint(x: 0.62, y: 0.78),
        CGPoint(x: 0.69, y: 0.95),
        CGPoint(x: 0.89, y: 0.07),
        CGPoint(x: 0.93, y: 0.20),
        CGPoint(x: 0.91, y: 0.47),
        CGPoint(x: 0.89, y: 0.75),
        CGPoint(x: 0.93, y: 0.89)
    ]

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.pastelBackground)
                .edgesIgnoringSafeArea(.all)

            GeometryReader { geometry in
                ForEach(0..<positions.count, id: \.self) { idx in
                    let pos = CGPoint(x: geometry.size.width * positions[idx].x, y: geometry.size.height * positions[idx].y)
                    Text(emojis.randomElement()!)
                        .font(.system(size: 80))
                        .opacity(0.6)
                        .contrast(0)
                        .position(pos)
                }
            }
        }
    }

    private func randomPosition(in size: CGSize) -> CGPoint {
        // Uniform distribution
        let distX = GKRandomDistribution(lowestValue: 0, highestValue: Int(size.width))
        let distY = GKRandomDistribution(lowestValue: 100, highestValue: Int(size.height))

        // Generate position
        let x = CGFloat(distX.nextInt())
        let y = CGFloat(distY.nextInt())

        return CGPoint(x: x, y: y)
    }
}

#Preview {
    EmojiBackground()
}
