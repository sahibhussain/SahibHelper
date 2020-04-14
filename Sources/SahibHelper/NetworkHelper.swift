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
    
    
//    MARK: -networkd related
    public func sharedBaseUrl(_ urlStr: String) {
        Networking.baseUrl = urlStr
    }
    
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
            
        }, to: urlString).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                comp(value as? [String: Any], nil)
            case .failure(let error):
                comp(nil, error)
            }
            
        }
        
    }
    
    public func sendGetRequest(urlExt: String, param: String, comp: @escaping CompletionHandler) {
        
        var urlString = Networking.baseUrl + urlExt + "?" + param
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        AF.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                comp(value as? [String: Any], nil)
            case .failure(let error):
                comp(nil, error)
            }
        }
        
    }
    
    public func sendGetRequest(completeUrl: String, param: String, comp: @escaping CompletionHandler) {
        
        var urlString = completeUrl + "?" + param
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        AF.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                comp(value as? [String: Any], nil)
            case .failure(let error):
                comp(nil, error)
            }
        }
        
    }
    
    
//    MARK: -json related
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
    
    
//    MARK: -date related
    public func changeDateFormat(_ inputString: String, inputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: inputString)!
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let dtString = dateFormatter.string(from: date)
        return dtString
    }
    
    public func changeDateFormatWithTime(_ inputString: String, inputFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: inputString)!
        
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
        let dtString = dateFormatter.string(from: date)
        return dtString
        
    }
    
    public func getLastDateOfMonth(month: String, year: String) -> String {
        let monthInt = Int(month)!
        let yearInt = Int(year)!
        
        if monthInt <= 7 {
            if monthInt % 2 == 0 {
                if monthInt == 2 {
                    if yearInt % 4 == 0 {
                        return "\(month)/29/\(year)"
                    }else {
                        return "\(month)/28/\(year)"
                    }
                }else {
                    return "\(month)/30/\(year)"
                }
            }else {
                return "\(month)/31/\(year)"
            }
        }else {
            if monthInt % 2 == 0 {
                return "\(month)/31/\(year)"
            }else {
                return "\(month)/30/\(year)"
            }
        }
    }
    
    
    
    
//    MARK: -alert
    public func alert(_ message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let act = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(act)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    
//    MARK: -regex related
    public func matches(_ string: String, regex: String) -> Bool {
        return string.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}
