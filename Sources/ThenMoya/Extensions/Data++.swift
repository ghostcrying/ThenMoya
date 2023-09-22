//
//  Data++.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Foundation

public extension Data {
    func map<T: Mapping>(mapType: T.Type) -> T? {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: [.allowFragments, .mutableLeaves]),
              let map = T(mapping: json)
        else {
            return nil
        }
        return map
    }
}
