//
//  ParseService.swift
//  Currency Converter
//
//  Created by Илья Варфоломеев on 2/9/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation

class ParseService {
    
    func parseCurrencyRatesResponse(data: Data?, toCurrency: String, baseCurrency: String) -> String {
        var value = ""
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any>
            if let parsedJSON = json {
                if let rates = parsedJSON["rates"] as? Dictionary<String, Double> {
                    if let rate = rates[toCurrency] {
                        value = "1 \(baseCurrency) = \(rate) \(toCurrency)"
                    } else {
                        value = "No rate for currency \"\(toCurrency)\" found"
                    }
                } else {
                    value = "No \"rates\" field found"
                }
            } else {
                value = "No json value parsed"
            }
        } catch {
            value = error.localizedDescription
        }
        
        return value
    }
    
    func parseCurrenciesResponse(data: Data?) -> [String] {
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any>
            if let parsedJSON = json {
                if let rates = parsedJSON["rates"] as? Dictionary<String, Double> {
                    return rates.flatMap() { $0.0 }
                }
            }
        } catch {
            // ignore
        }
        
        return []
    }
    
    func parseActualDate(data: Data?) -> Date? {
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any>
            if let parsedJSON = json {
                if let date = parsedJSON["date"] as? String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    return dateFormatter.date(from: date)
                }
            }
        } catch {
            // ignore
        }
        
        return nil
    }
}
