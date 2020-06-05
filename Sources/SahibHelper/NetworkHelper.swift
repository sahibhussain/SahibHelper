//
//  NetworkHelper.swift
//  SahibHelper
//
//  Created by sahib hussain on 08/06/18.
//  Copyright © 2018 Burning Desire Inclusive. All rights reserved.
//

import UIKit
import Alamofire

public class Networking {
    
    public static var baseUrl = "http://pcc123.com/API/SMSLiveDemo1/"  // Production URL
    
    public typealias CompletionHandler = (_ response: [String: Any]?, _ error: Error?) -> Void
    public var headers: [String: String] = [:]
    
    
    public static let shared = Networking()
    
    private init () {
        headers = ["Content-Type": "application/json"]
    }
    
    
    // MARK: - networkd related
    public func sendPostRequest(_ urlExt: String, param: [String: Any], comp: @escaping CompletionHandler) {
        
        let urlString = Networking.baseUrl + urlExt
        
        AF.request(urlString,method: .post, parameters: param, encoding: JSONEncoding.default, headers: HTTPHeaders(headers))
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    comp(value as? [String: Any], nil)
                case .failure(let error):
                    comp(nil, error)
                }
        }
    }
    
    public func sendPostRequest(_ urlExt: String, param: [String: String], withFile: [String: URL], comp: @escaping CompletionHandler) {
        
        let urlString = Networking.baseUrl + urlExt
        
        AF.upload(multipartFormData: { (formData) in
            
            for (key, value) in withFile {
                formData.append(value, withName: key)
            }
            
            for (key, value) in param {
                let data = value.data(using: .utf8)!
                formData.append(data, withName: key)
            }
            
        }, to: urlString, headers: HTTPHeaders(headers)).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                comp(value as? [String: Any], nil)
            case .failure(let error):
                comp(nil, error)
            }
            
        }
        
    }
    
    public func sendGetRequest(_ urlExt: String, param: String, comp: @escaping CompletionHandler) {
        
        var urlString = Networking.baseUrl + urlExt + "?" + param
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        AF.request(urlString, method: .get, headers: HTTPHeaders(headers)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                comp(value as? [String: Any], nil)
            case .failure(let error):
                comp(nil, error)
            }
        }
        
    }
    
    public func sendGetRequest(with completeUrl: String, param: String, comp: @escaping CompletionHandler) {
        
        var urlString = completeUrl + "?" + param
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        AF.request(urlString, method: .get, headers: HTTPHeaders(headers)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                comp(value as? [String: Any], nil)
            case .failure(let error):
                comp(nil, error)
            }
        }
        
    }
    
    
    // MARK: - json related
    public func jsonToString(_ json: [String: Any]) -> String{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let convertedString = String(data: data1, encoding: .utf8)
            return convertedString!
        } catch let myJSONError {
            print(myJSONError)
        }
        
        return "nil"
    }
    
    
    // MARK: - date related
    public func changeDateFormat(_ inputString: String, inputFormat: String, outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        guard let date = dateFormatter.date(from: inputString) else {
            print("inputDate format is not correct")
            return ""
        }
        
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
    
    public func getString(from date: Date,with outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
    
    public func getLastDateOfMonth(month: String, year: String) -> Date {
        let monthInt = Int(month)!
        let yearInt = Int(year)!
        
        var dateStr = ""
        
        if monthInt <= 7 {
            if monthInt % 2 == 0 {
                if monthInt == 2 {
                    if yearInt % 4 == 0 {
                        dateStr = "\(month)/29/\(year)"
                    }else {
                        dateStr = "\(month)/28/\(year)"
                    }
                }else {
                    dateStr = "\(month)/30/\(year)"
                }
            }else {
                dateStr = "\(month)/31/\(year)"
            }
        }else {
            if monthInt % 2 == 0 {
                dateStr = "\(month)/31/\(year)"
            }else {
                dateStr = "\(month)/30/\(year)"
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        return dateFormatter.date(from: dateStr)!
        
    }
    
    
    
    
    // MARK: - alert
    public func alert(_ message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let act = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(act)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
