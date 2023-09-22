//
//  ThenTargetType.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Moya

public protocol ThenTargetType: Moya.TargetType {
    
    var name: String? { get }
    
    var tag: Int? { get }
}

extension ThenTargetType {
    
    public var name: String? { nil }
    
    public var tag: Int? { nil }
    
}

