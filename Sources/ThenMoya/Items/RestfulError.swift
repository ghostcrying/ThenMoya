//
//  ThenRestfulError.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Foundation

/// inherir this protocol with restful response
public protocol RestfulError: Error, Mapping {
    
    var errorCode: Int { get set }

    var message: String { get set }
}

extension RestfulError {
    
    var errorCode: Int { 0 }

    var message: String { "" }

    var localizedDescription: String { message }
}
