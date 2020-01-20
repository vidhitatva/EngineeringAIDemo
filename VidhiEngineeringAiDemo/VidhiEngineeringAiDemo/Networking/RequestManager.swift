//
//  RequestManager.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 20/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import Foundation
import Alamofire

struct Request {
    var url : String
    var method : HTTPMethod
    var paramter : [String:Any]
    var headers : HTTPHeaders
}

class RequestManager {
    
    static public func requestWithGET(with url : String,complition : @escaping(_ status : Bool,_ responseData : Data,_ message : String) -> Void) {
        let req = self.createbody(url: url, method: .get, header: self.basicHeader, paramters: [:])
        self.sendRequest(request: req) { (status, result,message) in
            complition(status, result,message)
        }
    }
    
    static private func sendRequest(request : Request, complition:@escaping(_ status : Bool,_ result : Data,_ message : String) -> Void) {
        Alamofire.request(request.url, method: request.method, parameters: request.paramter, encoding: URLEncoding.default, headers: request.headers).responseData { (response) in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                        complition(true,response.result.value ?? Data(),"");
                    break
                case .failure:
                        complition(false,Data(),response.error?.localizedDescription ?? "")
                    break
                }
            }
        }
    }
    
    
    static private func createbody(url : String,method : HTTPMethod,header : HTTPHeaders,paramters: [String:Any]) -> Request{
        let request = Request(url: url, method: method, paramter: paramters, headers: header)
        return request
    }
    
    static private  var basicHeader : [String : String] {
        let headers = ["Content-Type" : "Application/json","Accept" : "Application/json"]
        return headers
    }
    
    static public func downloadingImage(url:String,complition:@escaping(_ status:Bool,_ image:Data) -> Void) {
        Alamofire.request(url).responseData { (image) in
            DispatchQueue.main.async {
                switch image.result {
                case .success:
                    complition(true,image.result.value ?? Data())
                    break
                case .failure:
                    complition(false,Data())
                    break
                }
            }
        }
    }
    
}
