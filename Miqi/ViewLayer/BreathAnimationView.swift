//
//  BreathAnimationView.swift
//  Miqi
//
//  Created by Elena Gordienko on 27.03.2022.
//

import SwiftUI

struct BreathAnimationView: View {
    @State var color: Color
    @State var scale: CGFloat = Constants.animationScale
    @State var rotationAngle: CGFloat = 0
    @Binding var animationState: AnimationState
    
    var body: some View {
        ZStack {
            makeCircle(rotation: Constants.angleDistance - Constants.angleOffset)
            makeCircle(rotation: Constants.angleDistance * 2 - Constants.angleOffset)
            makeCircle(rotation: Constants.angleDistance * 3 - Constants.angleOffset)
            makeCircle(rotation: Constants.angleDistance * 4 - Constants.angleOffset)
            makeCircle(rotation: Constants.angleDistance * 5 - Constants.angleOffset)
            makeCircle(rotation: Constants.angleDistance * 6 - Constants.angleOffset)
        }
        .rotationEffect(.degrees(rotationAngle))
        .scaleEffect(scale)
        .onChange(of: $animationState.wrappedValue) { newValue in
            switch newValue {
            case .ready, .stopped:
                return
            case .firstBreath:
                animate(scaleFactor: 0.6, angle: 60, animation: .easeIn(duration: 0.25))
            case .secondBreath:
                animate(scaleFactor: 1, angle: 90, animation: .easeIn(duration: 0.25))
            case .exhale:
                animate(scaleFactor: Constants.animationScale, angle: 0, animation: .easeOut(duration: 0.5))
            case .final:
                animate(scaleFactor: 1, angle: 45, animation: .easeInOut(duration: 0.5))
            }
        }
    }
    
    func animate(scaleFactor: CGFloat, angle: CGFloat, animation: Animation) {
        withAnimation(animation.speed(0.5)) {
            scale = scaleFactor
            rotationAngle = angle
        }
    }
    
    func makeCircle(
        size: CGFloat = Constants.size,
        offset: CGFloat = Constants.offset
    ) -> some View {
        Circle()
            .frame(width: size, height: size)
            .foregroundColor(color)
            .offset(y: offset)
            .opacity(Constants.opacity)
    }
    
    func makeCircle(rotation: Double) -> some View {
        makeCircle().rotationEffect(.degrees(rotation))
    }
    
    enum Constants {
        static let opacity: CGFloat = 0.25
        static let animationScale = 0.25
        static let animationSpeed = 0.10
        static let angleDistance: CGFloat = 60
        static let angleOffset: CGFloat = 15
        static let size: CGFloat = 80
        static var offset: CGFloat { size * 0.5 }
    }
}

struct BreathAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        BreathAnimationView(color: .mint, animationState: .constant(.stopped))
    }
}
