//
//  IRequestManager.swift
//  Currency Converter
//
//  Created by i.varfolomeev on 09/10/2019.
//  Copyright © 2019 Илья Варфоломеев. All rights reserved.
//

import Foundation

// MARK: - RequestConfig

public struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}

// MARK: - Result

public enum Result<Model> {
    case success(Model)
    case error(String)
}

// MARK: - IRequestManager

public protocol IRequestManager {
    func send<Parser>(requestConfig: RequestConfig<Parser>,
                      completionHandler: @escaping(Result<Parser.Model>) -> Void) -> URLSessionDataTask?
}

// MARK: - IRequest

public protocol IRequest {
    var urlRequest: URLRequest? { get }
}

// MARK: - IParser

public protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}
