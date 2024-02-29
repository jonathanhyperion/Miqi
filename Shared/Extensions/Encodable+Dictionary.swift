//
//  Encodable+Dictionary.swift
//  Miqi
//
//  Created by Elena Gordienko on 27.03.2022.
//

import Foundation

public extension Encodable {
    
    func asDictionary(encoder: JSONEncoder = JSONEncoder()) -> [String: Any]? {
        
        if let data = try? encoder.encode(self) {
            
            return try? JSONSerialization.jsonObject(
                with: data,
                options: .allowFragments
            ) as? [String: Any]
        }
        
        return nil
    }
}
