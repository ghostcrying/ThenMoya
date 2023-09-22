//
//  ThenResponse.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Foundation
import Moya

public struct ThenResponse<R> {
    public let response: Moya.Response

    public let value: R
}

public protocol MoyaWrapable {
    func wrap<M: Mapping>(mapType: M.Type) -> Result<M, MoyaError>
}

extension Result: MoyaWrapable where Success: MoyaWrapable, Failure: MoyaWrapable {
    public func wrap<M: Mapping>(mapType: M.Type) -> Result<M, MoyaError> {
        switch self {
        case let .success(box):
            return box.wrap(mapType: mapType)

        case let .failure(err):
            return err.wrap(mapType: mapType)
        }
    }
}

extension ThenResponse: MoyaWrapable {
    public func wrap<M>(mapType: M.Type) -> Result<M, MoyaError> where M: Mapping {
        guard let res = value as? M else {
            return response.map(mapType: mapType.self)
        }
        return .success(res)
    }
}

extension MoyaError: MoyaWrapable {
    public func wrap<M>(mapType: M.Type) -> Result<M, MoyaError> where M: Mapping {
        guard let response = response else {
            return .failure(self)
        }
        return response.map(mapType: mapType.self)
    }
}
