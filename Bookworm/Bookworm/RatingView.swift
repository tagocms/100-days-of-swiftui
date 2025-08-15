//
//  RatingView.swift
//  Bookworm
//
//  Created by Tiago Camargo Maciel dos Santos on 12/06/25.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
                case .increment:
                if rating < maximumRating {
                    rating += 1
                }
            case .decrement:
                if rating > 1 {
                    rating -= 1
                }
            default:
                break
            }
        }
    }
    
    func image(for number: Int) -> some View {
        if number > rating {
            offImage?.foregroundStyle(offColor) ?? onImage.foregroundStyle(offColor)
        } else {
            onImage.foregroundStyle(onColor)
        }
    }
}

#Preview {
    @State @Previewable var rating = 3
    RatingView(rating: $rating)
}
