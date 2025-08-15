//
//  Shapes.swift
//  iRollDice
//
//  Created by Tiago Camargo Maciel dos Santos on 08/08/25.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY * 0.5))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 1.5))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY * 1.5))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY * 0.5))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 0.5))
        }
    }
}

struct Octagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY * 0.5))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 1.5))
            path.addLine(to: CGPoint(x: rect.midX * 0.5, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY * 1.5))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY * 0.5))
            path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX * 0.5, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 0.5))
        }
    }
}

struct Decagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX * 0.25, y: rect.midY * 1.75))
            path.addLine(to: CGPoint(x: rect.midX * 0.75, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX * 1.25, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX * 1.75, y: rect.midY * 1.75))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            
            path.addLine(to: CGPoint(x: rect.midX * 1.75, y: rect.midY * 0.25))
            path.addLine(to: CGPoint(x: rect.midX * 1.25, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX * 0.75, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX * 0.25, y: rect.midY * 0.25))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct Dodecagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY * 0.5))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 1.5))
            path.addLine(to: CGPoint(x: rect.midX * 0.25, y: rect.midY * 1.75))
            path.addLine(to: CGPoint(x: rect.midX * 0.75, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX * 1.25, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX * 1.75, y: rect.midY * 1.75))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY * 1.5))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY * 0.5))
            
            path.addLine(to: CGPoint(x: rect.midX * 1.75, y: rect.midY * 0.25))
            path.addLine(to: CGPoint(x: rect.midX * 1.25, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX * 0.75, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.midX * 0.25, y: rect.midY * 0.25))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 0.5))
        }
    }
}

#Preview {
    Triangle()
}

#Preview {
    Hexagon()
}

#Preview {
    Octagon()
}

#Preview {
    Decagon()
}

#Preview {
    Dodecagon()
}

