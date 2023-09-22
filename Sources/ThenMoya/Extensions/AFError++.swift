//
//  AFError++.swift
//  ThenMoya
//
//  Created by ghost on 2023/9/20.
//

import Foundation
import Alamofire

extension AFError {
    
    public var statusCode: Int {
        switch self {
        case .createUploadableFailed(let error):            return error.statusCode
        case .createURLRequestFailed(let error):            return error.statusCode
        case .downloadedFileMoveFailed(let error, _, _):    return error.statusCode
        case .explicitlyCancelled:                          return URLError.cancelled.rawValue
        case .invalidURL:                                   return URLError.badURL.rawValue
        case .multipartEncodingFailed(let reason):          return reason.statusCode
        case .parameterEncodingFailed(let reason):          return reason.statusCode
        case .parameterEncoderFailed(let reason):           return reason.statusCode
        case .requestAdaptationFailed(let error):           return error.statusCode
        case .requestRetryFailed(_, let originalError):     return originalError.statusCode
        case .responseValidationFailed(let reason):         return reason.statusCode
        case .responseSerializationFailed(let reason):      return reason.statusCode
        case .serverTrustEvaluationFailed(_):               return URLError.serverCertificateUntrusted.rawValue
        case .sessionDeinitialized:                         return URLError.unknown.rawValue
        case .sessionInvalidated(let error):                return error?.statusCode ?? URLError.unknown.rawValue
        case .sessionTaskFailed(let error):                 return error.statusCode
        case .urlRequestValidationFailed(_):                return URLError.serverCertificateNotYetValid.rawValue
        }
    }
}

extension Alamofire.AFError.MultipartEncodingFailureReason {
    
    public var statusCode: Int {
        switch self {
        case .bodyPartURLInvalid(_):                                return URLError.requestBodyStreamExhausted.rawValue
        case .bodyPartFilenameInvalid(_):                           return URLError.fileDoesNotExist.rawValue
        case .bodyPartFileNotReachable(_):                          return URLError.cannotOpenFile.rawValue
        case .bodyPartFileNotReachableWithError(_, let error):      return error.statusCode
        case .bodyPartFileIsDirectory(_):                           return URLError.fileIsDirectory.rawValue
        case .bodyPartFileSizeNotAvailable(_):                      return URLError.noPermissionsToReadFile.rawValue
        case .bodyPartFileSizeQueryFailedWithError(_, let error):   return error.statusCode
        case .bodyPartInputStreamCreationFailed(_):                 return URLError.cannotOpenFile.rawValue
        case .outputStreamCreationFailed(_):                        return URLError.cannotCreateFile.rawValue
        case .outputStreamFileAlreadyExists(_):                     return URLError.cannotWriteToFile.rawValue
        case .outputStreamURLInvalid(_):                            return URLError.unsupportedURL.rawValue
        case .outputStreamWriteFailed(let error):                   return error.statusCode
        case .inputStreamReadFailed(let error):                     return error.statusCode
        }
    }
}

extension Alamofire.AFError.ParameterEncodingFailureReason {
    
    public var statusCode: Int {
        switch self {
        case .missingURL:                       return URLError.badURL.rawValue
        case .jsonEncodingFailed(let error):    return error.statusCode
        case .customEncodingFailed(let error):  return error.statusCode
        }
    }
}

extension Alamofire.AFError.ParameterEncoderFailureReason {
    
    public var statusCode: Int {
        switch self {
        case .missingRequiredComponent(_):  return URLError.badURL.rawValue
        case .encoderFailed(let error):     return error.statusCode
        }
    }
}

extension Alamofire.AFError.ResponseValidationFailureReason {
    
    public var statusCode: Int {
        switch self {
        case .dataFileNil:                          return URLError.zeroByteResource.rawValue
        case .dataFileReadFailed(_):                return URLError.cannotLoadFromNetwork.rawValue
        case .missingContentType(_):                return URLError.cannotDecodeContentData.rawValue
        case .unacceptableContentType(_, _):        return URLError.cannotDecodeContentData.rawValue
        case .unacceptableStatusCode(let code):     return code
        case .customValidationFailed(let error):    return error.statusCode
        }
    }
}

extension Alamofire.AFError.ResponseSerializationFailureReason {
    
    public var statusCode: Int {
        switch self {
        case .inputDataNilOrZeroLength:             return URLError.zeroByteResource.rawValue
        case .inputFileNil:                         return URLError.zeroByteResource.rawValue
        case .inputFileReadFailed(_):               return URLError.cannotWriteToFile.rawValue
        case .stringSerializationFailed(_):         return URLError.cannotDecodeRawData.rawValue
        case .jsonSerializationFailed(let error):   return error.statusCode
        case .decodingFailed(let error):            return error.statusCode
        case .customSerializationFailed(let error): return error.statusCode
        case .invalidEmptyResponse(_):              return URLError.zeroByteResource.rawValue
        }
    }
}
