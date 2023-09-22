//
//  MoyaResponse++.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Foundation
import Moya

public let ErrorDomain: String = "com.then.extension.moya.error.domain"

public extension Moya.Response {
    /// Origin Mapping
    func map<T: Mapping>(mapType: T.Type) -> Result<T, MoyaError> {
        do {
            let json = try mapJSON()
            guard let mapped = T(mapping: json) else {
                return .failure(MoyaError.jsonMapping(self))
            }
            return .success(mapped)
        } catch {
            let userInfo: [String: Any] = [
                "statusCode": statusCode,
                NSLocalizedDescriptionKey: NormalErrorMessage + "(\(statusCode))",
            ]
            let customError = NSError(
                domain: ErrorDomain,
                code: statusCode,
                userInfo: userInfo
            )
            return .failure(.underlying(customError, self))
        }
    }

    /// Target Mapping
    func map<T: Mapping>(mapType: T.Type, thenTarget: ThenTargetType) -> Result<T, MoyaError> {
        do {
            let json = try mapJSON()
            guard let mapped = T(mapping: json) else {
                return .failure(MoyaError.jsonMapping(self))
            }
            return .success(mapped)
        } catch {
            var codeText: String = ""
            if let tag = thenTarget.tag {
                codeText = "\(tag)-\(statusCode)"
            } else {
                codeText = "\(statusCode)"
            }
            let userInfo: [String: Any] = [
                "statusCode": statusCode,
                NSLocalizedDescriptionKey: NormalErrorMessage + "(\(codeText))",
            ]
            let customError = NSError(
                domain: ErrorDomain,
                code: statusCode,
                userInfo: userInfo
            )
            return .failure(.underlying(customError, self))
        }
    }

    /// Origin Restful Mapping
    func mapRestful<T: Mapping, R: RestfulError>(mapType: T.Type, restful: R.Type) -> Result<T, MoyaError> {
        do {
            let json = try mapJSON()
            if (200 ..< 300).contains(statusCode) {
                guard let mapped = T(mapping: json) else {
                    return .failure(MoyaError.jsonMapping(self))
                }
                return .success(mapped)
            }
            guard let error = R(mapping: json) else {
                return .failure(MoyaError.jsonMapping(self))
            }
            return .failure(.underlying(error, self))
        } catch {
            let userInfo: [String: Any] = [
                "statusCode": statusCode,
                NSLocalizedDescriptionKey: NormalErrorMessage + "(\(statusCode))",
            ]
            let customError = NSError(
                domain: ErrorDomain,
                code: statusCode,
                userInfo: userInfo
            )
            return .failure(.underlying(customError, self))
        }
    }

    /// Target Restful Mapping
    func mapRestful<T: Mapping, R: RestfulError>(mapType: T.Type, restful: R.Type, thenTarget: ThenTargetType) -> Result<T, MoyaError> {
        do {
            let json = try mapJSON()
            if (200 ..< 300).contains(statusCode) {
                guard let mapped = T(mapping: json) else {
                    return .failure(MoyaError.jsonMapping(self))
                }
                return .success(mapped)
            }
            guard let error = R(mapping: json) else {
                return .failure(MoyaError.jsonMapping(self))
            }
            return .failure(.underlying(error, self))
        } catch {
            var codeText: String = ""
            if let tag = thenTarget.tag {
                codeText = "\(tag)-\(statusCode)"
            } else {
                codeText = "\(statusCode)"
            }
            let userInfo: [String: Any] = [
                "statusCode": statusCode,
                NSLocalizedDescriptionKey: NormalErrorMessage + "(\(codeText))",
            ]
            let customError = NSError(
                domain: ErrorDomain,
                code: statusCode,
                userInfo: userInfo
            )
            return .failure(.underlying(customError, self))
        }
    }
}
