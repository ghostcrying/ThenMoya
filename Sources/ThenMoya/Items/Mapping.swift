//
//  Mapping.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/19.
//

import Foundation
import Moya

///  Use
///  ```
///  // ObjectMapper
///  struct Example: Mapping, Mappable {
///      init?(Mapping: Any) {
///         if let json = mapping as? [String: Any] {
///             self.init(JSON: json)
///         } else {
///             return nil
///         }
///      }
///      ...
///  }
///  // SwiftyJSON
///  struct Example: Mapping {
///      init?(Mapping: Any) {
///         if let json = JSON(json) {
///             ...
///         } else {
///             return nil
///         }
///      }
///      ...
///  }
///  ```
public protocol Mapping {
    init?(mapping: Any)
}
