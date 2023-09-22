//
//  MoyaError++.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Foundation
import Moya
import Alamofire

extension MoyaError {
    
    public var statusCode: Int {
        switch self {
        case .imageMapping(let response):       return response.statusCode
        case .jsonMapping(let response):        return response.statusCode
        case .stringMapping(let response):      return response.statusCode
        case .objectMapping(_, let response):   return response.statusCode
        case .statusCode(let response):         return response.statusCode
        case .requestMapping(_):                return 0
        case .encodableMapping(let error):      return error.statusCode
        case .parameterEncoding(let error):     return error.statusCode
        case .underlying(let error, _):         return error.statusCode
        }
    }
}

extension Moya.MoyaError {
    
    public func format(by target: Moya.TargetType) -> Moya.MoyaError {
        
        if isCancelled { return self }
        
        let finalCodeTextClosure: (_ target: ThenMoya.ThenTargetType?, _ code: Int) -> String = { (target, code) in
            guard let tag = target?.tag else { return "\(code)" }
            return "\(tag)-\(code)"
        }
        
        let errorClosure: (_ code: Int, _ text: String, _ desc: String) -> Error = { (code, text, desc) in
            let prefix: String = desc.isEmpty ? NormalErrorMessage : desc
            return NSError(domain: ErrorDomain, code: code, userInfo: ["statusCode": code, NSLocalizedDescriptionKey: "\(prefix)(\(text))"])
        }
        
        let errorCode = statusCode
        let text = finalCodeTextClosure(target as? ThenMoya.ThenTargetType, errorCode)
        let error = errorClosure(errorCode, text, shortLocalizedDescription)
        
        switch self {
        case .imageMapping(let response):       return .underlying(error, response)
        case .jsonMapping(let response):        return .underlying(error, response)
        case .stringMapping(let response):      return .underlying(error, response)
        case .objectMapping(_, let response):   return .objectMapping(error, response)
        case .encodableMapping(_):              return .underlying(error, response)
        case .statusCode(let response):         return .underlying(error, response)
        case .underlying(_, let response):      return .underlying(error, response)
        case .requestMapping(_):                return .underlying(error, nil)
        case .parameterEncoding(_):             return .parameterEncoding(error)
        }
    }
}

extension Error {
    
    var shortLocalizedDescription: String {
        return localizedDescription.replacingOccurrences(of: "URLSessionTask failed with error: ", with: "")
    }
}
