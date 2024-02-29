//
//  View+isHidden.swift
//  Miqi
//
//  Created by Elena Gordienko on 27.03.2022.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, shouldBeRemoved: Bool = false) -> some View {
        if hidden {
            if !shouldBeRemoved { self.hidden() }
        } else {
            self
        }
    }
}
