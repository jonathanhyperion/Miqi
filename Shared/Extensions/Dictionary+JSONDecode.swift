//
//  Dictionary+JSONDecode.swift
//  Miqi
//
//  Created by Jonathan Solorzano on 3/5/22.
//

import Foundation

extension Data {
    func decode<T: Decodable>(JSONDecoder: JSONDecoder = JSONDecoder()) -> T? {
        return try? JSONDecoder.decode(T.self, from: self)
    }
}
