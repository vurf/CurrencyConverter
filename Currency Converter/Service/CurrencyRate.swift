//
//  CurrencyRate.swift
//  Currency Converter
//
//  Created by i.varfolomeev on 09/10/2019.
//  Copyright © 2019 Илья Варфоломеев. All rights reserved.
//

import Foundation

public struct CurrencyRate: Decodable {
    public let rate: String
}

final class CurrencyRateParser: IParser {
    typealias Model = CurrencyRate
    
    func parse(data: Data) -> CurrencyRate? {
        return try? JSONDecoder().decode(CurrencyRate.self, from: data)
    }
}
