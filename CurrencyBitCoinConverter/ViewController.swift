//
//  ViewController.swift
//  CurrencyBitCoinConverter
//
//  Created by Practica on 1/11/17.
//  Copyright © 2017 UTADEO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB"]
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    var finalURL : String?
    
    override func viewDidLoad() {
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(currencyArray[row])
        finalURL = baseURL + currencyArray[row]
        getBitcoinData(url: finalURL!)
    }
    //MARK - NETWORKING
    func getBitcoinData(url: String){
        Alamofire.request(url, method: .get).responseJSON{
            (response) in
            if response.result.isSuccess{
                let bitcoinJSON : JSON = JSON(response.result.value!)
                self.updateBitcoinData(json: bitcoinJSON)
            }else{
                print ("Error: \(response.result.error)")
                self.labelPrice.text = "Se presemtp im problema en la conexion"
            }
        }
    }
    func updateBitcoinData(json: JSON){
        if let bitcoinResult = json["ask"].double{
            labelPrice.text = String (bitcoinResult)
        }
        else{
            labelPrice.text = "Servicio no Disponible"
        }
    }

}

