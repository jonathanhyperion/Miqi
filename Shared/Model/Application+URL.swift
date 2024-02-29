//
//  Application+URL.swift
//  Miqi
//
//  Created by Elena Gordienko on 31.03.2022.
//

import Foundation

extension Application {
    var url: URL? { URL(string: urlScheme) }
    
    private var urlScheme: String {
        switch self {
        case .unknown:
            return "-"
        case .instagram:
            return "instagram://"
        case .tiktok:
            return "tiktok://"
        case .youtube:
            return "youtube://"
        case .twitter:
            return "twitter://"
        case .reddit:
            return "reddit://"
        case .zenly:
            return "zenly://"
        case .hearthstone:
            return "hearthstone://"
        case .minecraft:
            return "minecraft://"
        case .facebook:
            return "fb://"
        }
    }
}

