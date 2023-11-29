//
//  EmojiBackground.swift
//  Sizzle
//
//  Created by Roland Kajatin on 26/11/2023.
//

import SwiftUI
import GameplayKit

struct EmojiBackground: View {
    let numberOfEmojis = 20
    let emojis = ["🍎", "🍓", "🍍", "🥝", "🍔", "🍩", "🍽️", "🍤", "🍰", "🥦", "🌽", "🍉"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.pastelBackground)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                ForEach(0..<numberOfEmojis, id: \.self) { _ in
                    Text(emojis.randomElement()!)
                        .font(.system(size: 80))
                        .opacity(0.6)
                        .contrast(0)
                        .position(randomPosition(in: geometry.size))
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
