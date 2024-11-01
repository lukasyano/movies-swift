import SwiftUI

public struct RandomGradient {
    private static func randomColor() -> Color {
        Color(
            red: Double.random(in: 0 ... 1),
            green: Double.random(in: 0 ... 1),
            blue: Double.random(in: 0 ... 1)
        )
    }

    public static func generate() -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [randomColor(), randomColor()]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
