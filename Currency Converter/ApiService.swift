//
//  Services.swift
//  Currency Converter
//
//  Created by Илья Варфоломеев on 2/9/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

class ApiService {
    
    func requestCurrencyRates(baseCurrency: String, parseHandler: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: "https://api.fixer.io/latest?base=" + baseCurrency)!
        let dataTask = URLSession.shared.dataTask(with: url) {
            (dataReceived, response, error) in
            parseHandler(dataReceived, error)
        }
        
        dataTask.resume()
    }
    
    func requestCurrencies(parseHandler: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: "https://api.fixer.io/latest")!
        let dataTask = URLSession.shared.dataTask(with: url) {
            (dataReceived, response, error) in
            parseHandler(dataReceived, error)
        }
        
        dataTask.resume()
    }
}
