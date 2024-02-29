//
//  Application+Name.swift
//  Miqi
//
//  Created by Elena Gordienko on 27.03.2022.
//

import Foundation

extension Application {
    var name: String {
        switch self {
        case .unknown:
            return "-"
        case .instagram:
            return "Instagram"
        case .tiktok:
            return "TikTok"
        case .youtube:
            return "YouTube"
        case .twitter:
            return "Twitter"
        case .reddit:
            return "Reddit"
        case .zenly:
            return "Zenly"
        case .hearthstone:
            return "Hearthstone"
        case .minecraft:
            return "Minecraft"
        case .facebook:
            return "Facebook"
        }
    }
}
