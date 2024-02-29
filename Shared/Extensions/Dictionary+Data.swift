//
//  Dictionary+Data.swift
//  Miqi
//
//  Created by Jonathan Solorzano on 29/4/22.
//

import Foundation

extension Dictionary {
    
    var data: Data? {
        return try? JSONSerialization.data(withJSONObject: self)
    }
}
