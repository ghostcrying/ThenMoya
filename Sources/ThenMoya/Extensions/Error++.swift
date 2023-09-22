//
//  Error++.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Alamofire
import Foundation
import Moya

internal let NormalErrorMessage = "出错了，请稍后重试"

public extension Error {
    var statusCode: Int {
        if let alamofireError = self as? AFError {
            return alamofireError.statusCode
        }
        if let moyaError = self as? MoyaError {
            return moyaError.statusCode
        }
        return (self as NSError).code
    }

    var isCancelled: Bool {
        statusCode == URLError.cancelled.rawValue
    }
}
