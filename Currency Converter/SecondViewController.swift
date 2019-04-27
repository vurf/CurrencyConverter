//
//  SecondViewController.swift
//  Currency Converter
//
//  Created by Илья Варфоломеев on 2/9/18.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var baseCurrencyLabel : UILabel!
    @IBOutlet weak var toCurrencyLabel : UILabel!
    @IBOutlet weak var changeCurrencyButton: UIButton!
    @IBOutlet weak var baseCurrencyField: UITextField!
    @IBOutlet weak var toCurrencyField: UITextField!
    
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dummyView = UIView(frame: CGRect.zero)
        self.baseCurrencyField.inputView = dummyView
        self.toCurrencyField.inputView = dummyView
        
        self.changeCurrencyButton.addTarget(self, action: #selector(self.makeExchange), for: .touchUpInside)
        
        self.oneButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.twoButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.threeButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.fourButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.fiveButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.sixButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.sevenButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.eightButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.nineButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.dotButton.addTarget(self, action: #selector(self.dotButtonClicked), for: .touchUpInside)
        self.zeroButton.addTarget(self, action: #selector(self.additionValue), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(self.backButtonClicked), for: .touchUpInside)
        
        self.baseCurrencyField.becomeFirstResponder()
    }

    var selectedField: UITextField? {
        get {
            if self.toCurrencyField.isFirstResponder {
                return self.toCurrencyField
            }
            
            if self.baseCurrencyField.isFirstResponder {
                return self.baseCurrencyField
            }
            
            return nil
        }
    }
    
    var fakeCurrency: Double = 56.2
    
    var privateInverseCurrency: Bool = false
    
    var inverseCurrency: Bool {
        get {
            return self.privateInverseCurrency
        } set {
            self.privateInverseCurrency = newValue
            self.fakeCurrency = newValue ? (1 / self.fakeCurrency) : self.fakeCurrency
        }
    }
    
    @objc func makeExchange() {
        var labelText = self.baseCurrencyLabel.text;
        self.baseCurrencyLabel.text = self.toCurrencyLabel.text
        self.toCurrencyLabel.text = labelText
        self.inverseCurrency = !self.inverseCurrency
        self.updateCurrency()
    }
    
    @objc func additionValue(_ sender: UIButton) {
        if self.selectedField == nil || self.selectedField!.text!.count > 8 {
            return
        }
    
        let value = sender.title(for: .normal)
        self.selectedField!.text = self.selectedField!.text! + value!
        
        self.updateCurrency()
    }
    
    @objc func dotButtonClicked() {
        print("dot not working")
    }
    
    @objc func backButtonClicked() {
        if self.selectedField?.text?.isEmpty == true {
            return;
        }
        
        self.selectedField?.text?.removeLast()
        self.updateCurrency()
    }
    
    func updateCurrency() {
        if self.baseCurrencyField.isFirstResponder {
            let result = Double(self.baseCurrencyField.text!)! * self.fakeCurrency
            self.toCurrencyField.text = String(result)
        }
    }
}

