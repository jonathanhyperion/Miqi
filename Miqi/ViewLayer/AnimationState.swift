//
//  AnimationState.swift
//  Miqi
//
//  Created by Elena Gordienko on 29.03.2022.
//

import Foundation

enum AnimationState: Equatable {
    case ready
    case firstBreath
    case secondBreath
    case exhale
    case final
    case stopped
    
    var inProgress: Bool {
        switch self {
        case .firstBreath, .secondBreath, .exhale, .final:
            return true
        default:
            return false
        }
    }
}
