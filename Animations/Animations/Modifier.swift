//
//  Modifier.swift
//  Animations
//
//  Created by Tiago Camargo Maciel dos Santos on 15/05/25.
//

import SwiftUI

struct CornerRounderModifier: ViewModifier {
    var degrees: Double
    var anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(degrees), anchor: anchor)
            .clipped()
    }
    
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRounderModifier(degrees: -90, anchor: .topLeading),
            identity: CornerRounderModifier(degrees: 0, anchor: .topLeading)
        )
    }
}
