//
//  Provider++.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/19.
//

import Foundation
import Moya

public extension MoyaProviderType where Target: Moya.TargetType {
    @discardableResult
    func request<T: Mapping>(
        _ target: Target,
        mapType: T.Type,
        progress: Moya.ProgressBlock? = .none,
        callbackQueue: DispatchQueue = .main,
        completion: @escaping (Result<ThenResponse<T>, MoyaError>) -> Void
    ) -> Moya.Cancellable {
        self.request(target, callbackQueue: callbackQueue, progress: progress) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error.format(by: target)))

            case let .success(response):
                let value = response.map(mapType: mapType)
                switch value {
                case let .failure(error):
                    completion(.failure(error))

                case let .success(mapped):
                    completion(.success(ThenResponse<T>(response: response, value: mapped)))
                }
            }
        }
    }

    @discardableResult
    func request<T: Mapping, E: RestfulError>(
        _ target: Target,
        mapType: T.Type,
        restful: E.Type,
        progress: Moya.ProgressBlock? = .none,
        callbackQueue: DispatchQueue = .main,
        completion: @escaping (Result<ThenResponse<T>, MoyaError>) -> Void
    ) -> Moya.Cancellable {
        self.request(target, callbackQueue: callbackQueue, progress: progress) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error.format(by: target)))

            case let .success(response):
                let value = response.mapRestful(mapType: mapType, restful: restful)
                switch value {
                case let .failure(error):
                    completion(.failure(error))

                case let .success(mapped):
                    completion(.success(ThenResponse<T>(response: response, value: mapped)))
                }
            }
        }
    }
}

public extension MoyaProviderType where Target: ThenTargetType {
    @discardableResult
    func request<T: Mapping>(
        _ target: Target,
        mapType: T.Type,
        progress: Moya.ProgressBlock? = .none,
        callbackQueue: DispatchQueue = .main,
        completion: @escaping (Result<ThenResponse<T>, MoyaError>) -> Void
    ) -> Moya.Cancellable {
        self.request(target, callbackQueue: callbackQueue, progress: progress) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error.format(by: target)))

            case let .success(response):
                let value = response.map(mapType: mapType, thenTarget: target)
                switch value {
                case let .failure(error):
                    completion(.failure(error))

                case let .success(mapped):
                    completion(.success(ThenResponse<T>(response: response, value: mapped)))
                }
            }
        }
    }

    @discardableResult
    func request<T: Mapping, E: RestfulError>(
        _ target: Target,
        mapType: T.Type,
        restful: E.Type,
        progress: Moya.ProgressBlock? = .none,
        callbackQueue: DispatchQueue = .main,
        completion: @escaping (Result<ThenResponse<T>, MoyaError>) -> Void
    ) -> Moya.Cancellable {
        self.request(target, callbackQueue: callbackQueue, progress: progress) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error.format(by: target)))

            case let .success(response):
                let value = response.mapRestful(mapType: mapType, restful: restful, thenTarget: target)
                switch value {
                case let .failure(error):
                    completion(.failure(error))

                case let .success(mapped):
                    completion(.success(ThenResponse<T>(response: response, value: mapped)))
                }
            }
        }
    }
}
