//
//  CurrencyRateRequest.swift
//  Currency Converter
//
//  Created by i.varfolomeev on 09/10/2019.
//  Copyright © 2019 Илья Варфоломеев. All rights reserved.
//

import Foundation

final class CurrencyRateRequest: IRequest {
    
    private let currency: String
    
    init(currency: String) {
        self.currency = currency
    }
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {
        guard let url = compositeUrl else { return nil }
        return URLRequest(url: url)
    }
    
    // MARK: - Private
    
    private var compositeUrl: URL? {
        // https://api.fixer.io/latest?base="
        let methodQuery = URLQueryItem(name: "base", value: currency)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.fixer.io"
        components.path = "/latest"
        components.queryItems = [methodQuery]
        return components.url
    }
}
