//
//  CurrencyService.swift
//  Currency Converter
//
//  Created by i.varfolomeev on 09/10/2019.
//  Copyright © 2019 Илья Варфоломеев. All rights reserved.
//

import Foundation

public protocol ICurrencyService {
    
}

final class CurrencyService: ICurrencyService {
    
    private let requestManager: IRequestManager
    
    init(requestManager: IRequestManager) {
        self.requestManager = requestManager
    }
    
    func loadCurrencies(completion: @escaping(Result<>) -> Void) {
        
    }
}
