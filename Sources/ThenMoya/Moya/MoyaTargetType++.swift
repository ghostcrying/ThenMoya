//
//  MoyaTargetType++.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Foundation
import Moya

public extension Moya.TargetType {
    var identifer: String {
        return baseURL.absoluteString + path + "?method=" + method.rawValue
    }

    var cacheKey: String {
        let key = baseURL.absoluteString + "#" + path + "#" + method.rawValue
        switch task {
        case .requestPlain:
            return key.md5

        case let .requestData(data):
            return "\(key)\(data)".md5

        case let .requestParameters(para, _):
            let paraIdentifier = para
                .compactMap {
                    "\($0.key):\($0.value)"
                }
                .sorted()
                .joined(separator: "#")
            return "\(key)\(paraIdentifier)".md5

        case let .requestCompositeData(data, para):
            let paraIdentifier = para
                .compactMap {
                    "\($0.key):\($0.value)"
                }
                .sorted()
                .joined(separator: "#")
            return "\(key)\(paraIdentifier)\(data)".md5

        case let .requestCompositeParameters(bd, _, para):
            let paraIdentifier = para
                .compactMap {
                    "\($0.key):\($0.value)"
                }
                .sorted()
                .joined(separator: "#")
            return "\(key)\(paraIdentifier)\(bd)".md5

        default:
            return key
        }
    }
}
