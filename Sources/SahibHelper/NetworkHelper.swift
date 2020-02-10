//
//  NetworkHelper.swift
//  SahibHelper
//
//  Created by sahib hussain on 08/06/18.
//  Copyright © 2018 Burning Desire Inclusive. All rights reserved.
//

import UIKit
import Alamofire

class Networking {
    
//    #warning("Change url to production")
//    let baseUrl = "http://pcc123.com/API/SMSDEMO1/"  // Development URL
    var baseUrl = "http://pcc123.com/API/SMSLiveDemo1/"  // Production URL
    
    typealias completionHandler = (_ response: [String:Any]?, _ error: Error?) -> Void
    var headers: [String: String] = [:]
    
    
    static let shared = Networking()
    
    private init () {
        headers = ["Content-Type": "application/json"]
    }
    
    func sharedBaseUrl(_ urlStr: String) {
        baseUrl = urlStr
    }
    
    func sendPostRequest(urlExt: String, param: [String:Any], comp: @escaping completionHandler) {
        let urlString = "\(baseUrl)\(urlExt)"
        
        AF.request(urlString,method: .post, parameters: param, encoding: JSONEncoding.default, headers: HTTPHeaders(headers))
            .responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    comp(value as? [String:Any], nil)
                case .failure(let error):
                    comp(nil, error)
                }
        }
    }
    
    func sendGetRequest(urlExt: String, param: String, comp: @escaping completionHandler) {
        
        var urlString = "\(baseUrl)\(urlExt)?\(param)"
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        
        AF.request(urlString).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                comp(value as? [String:Any], nil)
            case .failure(let error):
                comp(nil, error)
            }
        }
        
    }
    
    func jsonToString(json: [String:Any]) -> String{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let convertedString = String(data: data1, encoding: .utf8)
            return convertedString!
        } catch let myJSONError {
            print(myJSONError)
        }
        
        return "nil"
    }
    
    func changeDateFormat(inputString: String, inputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: inputString)!
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let dtString = dateFormatter.string(from: date)
        return dtString
    }
    
    func changeDateFormatWithTime(inputString: String, inputFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        let date = dateFormatter.date(from: inputString)!
        
        dateFormatter.dateFormat = "MMM dd, yyyy h:mm a"
        let dtString = dateFormatter.string(from: date)
        return dtString
        
    }
    
    func getLastDateOfMonth(month: String, year: String) -> String {
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
    
    func alert(message:String, viewController: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let act = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(act)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    /*
    func logout(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let act = UIAlertAction(title: "OK", style: .cancel) { (action) in
            let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "Login")
            vc!.modalPresentationStyle = .fullScreen
            viewController.present(vc!, animated: true) {
                UserSettings.delete(file: .user)
            }
        }
        alert.addAction(act)
        viewController.present(alert, animated: true, completion: nil)
    }
    */
    
    func matches(_ string: String, regex: String) -> Bool {
        return string.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}
