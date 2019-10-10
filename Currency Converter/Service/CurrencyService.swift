//
//  CurrencyService.swift
//  Currency Converter
//
//  Created by i.varfolomeev on 09/10/2019.
//  Copyright © 2019 Илья Варфоломеев. All rights reserved.
//

import Foundation

public protocol ICurrencyService {
    func loadCurrencies(currency: String, completion: @escaping(Result<CurrencyRate>) -> Void)
}

final class CurrencyService: ICurrencyService {
    
    private let requestManager: IRequestManager
    
    init(requestManager: IRequestManager) {
        self.requestManager = requestManager
    }
    
    func loadCurrencies(currency: String, completion: @escaping(Result<CurrencyRate>) -> Void) {
        let request = CurrencyRateRequest(currency: currency)
        let config = RequestConfig(request: request, parser: CurrencyRateParser())
        requestManager.send(requestConfig: config, completionHandler: completion)
    }
}
