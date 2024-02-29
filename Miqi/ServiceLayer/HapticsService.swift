//
//  HapticsService.swift
//  Miqi
//
//  Created by Elena Gordienko on 29.03.2022.
//

import UIKit

final class HapticsService {
    static let shared = HapticsService()
    
    private init() { }
    
    func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
