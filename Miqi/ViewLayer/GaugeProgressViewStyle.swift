//
//  GaugeProgressViewStyle.swift
//  Miqi
//
//  Created by Elena Gordienko on 02.04.2022.
//

import Foundation
import SwiftUI

struct GaugeProgressViewStyle: ProgressViewStyle {
    private let strokeColor: Color
    private let strokeWidth: CGFloat
    private let rotationDegrees: CGFloat

    init(strokeColor: Color, strokeWidth: CGFloat = 10.0, rotationDegrees: CGFloat = -90) {
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
        self.rotationDegrees = rotationDegrees
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return Circle()
            .trim(from: 0, to: CGFloat(fractionCompleted))
            .stroke(
                strokeColor,
                style: StrokeStyle(
                    lineWidth: CGFloat(strokeWidth),
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(rotationDegrees))
    }
}
