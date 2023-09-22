//
//  String++.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import CommonCrypto
import CryptoKit
import Foundation

/// MD5
public extension String {
    var md5: String {
        if #available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, *) {
            if let d = data(using: .utf8) {
                return Insecure.MD5.hash(data: d).map { String(format: "%02hhx", $0) }.joined()
            }
            return ""
        } else {
            let str = cString(using: String.Encoding.utf8) ?? []
            let strLen = CUnsignedInt(lengthOfBytes(using: String.Encoding.utf8))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            defer { result.deallocate() }
            CC_MD5(str, strLen, result)
            return stringFromResult(result: result, length: digestLen)
        }
    }
}

private extension String {
    func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0 ..< length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash).lowercased()
    }
}
