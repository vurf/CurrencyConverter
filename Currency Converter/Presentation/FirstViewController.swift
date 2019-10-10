//
//  FirstViewController.swift
//  Currency Converter
//
//  Created by Илья Варфоломеев on 2/9/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var pickerFrom : UIPickerView!
    @IBOutlet weak var pickerTo : UIPickerView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    private lazy var currencyService: ICurrencyService = {
        let requestManager: IRequestManager = RequestManager()
        return CurrencyService(requestManager: requestManager)
    }()
    
    var currencies : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retriveAllCurrencies()
        self.pickerFrom.dataSource = self
        self.pickerTo.dataSource = self
        self.pickerFrom.delegate = self
        self.pickerTo.delegate = self
        self.activityIndicator.hidesWhenStopped = true
    }
    
    func requestCurrentCurrencyRate() {
        self.activityIndicator.startAnimating()
        self.label.text = ""
        
        let baseCurrencyIndex = self.pickerFrom.selectedRow(inComponent: 0)
        let toCurrencyIndex = self.pickerTo.selectedRow(inComponent: 0)
        
        let baseCurrency = self.currencies.isEmpty ? "" : self.currencies[baseCurrencyIndex]
        let toCurrency = self.currencies.isEmpty ? "" : self.currenciesExceptBase()[toCurrencyIndex]
        
        self.retriveCurrencyRate(baseCurrency: baseCurrency, toCurrency: toCurrency) {[weak self] (value) in
            DispatchQueue.main.async {
                if let strongSelf = self {
                    strongSelf.label.text = value
                    strongSelf.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func retriveCurrencyRate(baseCurrency: String, toCurrency: String, completion: @escaping (String) -> Void) {
        currencyService.loadCurrencies(currency: baseCurrency) { [weak self] (result) in
            var string = "No currency retrived!"
            switch result {
            case .error(let error):
                string = error.localizedDescription
            case .success(let model):
                string = model.rate
            }
            
            completion(string)
        }
    }
    
    func retriveAllCurrencies() -> Void {
        self.label.text = ""
        self.dateLabel.text = ""
        self.activityIndicator.startAnimating()
        self.apiService.requestCurrencies() {[weak self] (data, error) in
            DispatchQueue.main.async {
                if let strongSelf = self {
                    if let currenciesData = data {
                        strongSelf.currencies = strongSelf.parseService.parseCurrenciesResponse(data: currenciesData).sorted()
                        
                        var date = strongSelf.parseService.parseActualDate(data: currenciesData)
                        var dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd.MM.yyyy"
//                        strongSelf.dateLabel.text = "\(dateFormatter.string(from: date!))"
                    }
                    
                    strongSelf.pickerFrom.reloadAllComponents()
                    strongSelf.pickerTo.reloadAllComponents()
                    strongSelf.requestCurrentCurrencyRate()
                }
            }
        }
    }
    
    func currenciesExceptBase() -> [String] {
        if self.currencies.isEmpty {
            return []
        }
        
        var currenciesExceptBase = currencies
        currenciesExceptBase.remove(at: pickerFrom.selectedRow(inComponent: 0))
        return currenciesExceptBase
    }
    
    // MARK UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === pickerTo {
            return self.currenciesExceptBase().count
        }
        
        return self.currencies.count
    }
    
    // MARK UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView === pickerTo {
            return NSAttributedString(string: self.currenciesExceptBase()[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
        
        return NSAttributedString(string: self.currencies[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === pickerFrom {
            self.pickerTo.reloadAllComponents()
        }
        
        self.requestCurrentCurrencyRate()
    }
}
