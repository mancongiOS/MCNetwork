//
//  MCNetwork.swift
//  MCNetwork
//
//  Created by MC on 2018/7/13.
//  Copyright © 2018年 MC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON




struct MCErrorDetail {
    var code : String
    var message : String
}

enum MCError <T> {
    case codeError(T)
    case networkNull
    case wrongReturn
}

struct MCNetwork {
    
    typealias Success<T> = (JSON) -> ()
    typealias Failure<T> = (MCError<MCErrorDetail>) -> ()
    
    @discardableResult
    public static func POST(_ url: String!, _ params:[String:Any]? = [String:Any](), _ queue:DispatchQueue? = nil,success: @escaping Success<JSON>, failure: Failure<MCError<MCErrorDetail>>? = nil) -> DataRequest {
        
        
        return Alamofire.request(url, method: .post,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: ["Content-Type":"application/json"])
            .responseJSON(queue: queue) { (response) in
                
                let result = response.result

                
                // 网络异常 没访问到服务器
                if result.isFailure {
                    if (failure != nil) {
                        failure!(.networkNull)
                    }
                }
                
                
                if response.result.isSuccess {
                    
                    // 有效的返回的数据
                    if let data = response.result.value as? [String:Any] {
                        
                        let code = data["code"] as? NSNumber ?? 0
                        let message = data["message"] as? String ?? ""
                        

                        // 想要的返回的结果处理
                        if code.intValue == 10000 {
                            
                            let json = JSON(data)
                            success(json["data"])
                        } else {   // 异常的结果处理
                            let error = MCErrorDetail(code: code.stringValue,message: message)
                          
                            if (failure != nil) {
                                failure!(.codeError(error))
                            }
                        }
                        
                    } else {   // 异常的数据结构
                        
                        if (failure != nil) {
                            failure!(.wrongReturn)
                        }
                    }
                }
        }
    }
    
    
    
    
    
    
    // GET
    @discardableResult
    public static func GET(_ url: String!, _ params:[String:Any]? = [String:Any](), _ queue:DispatchQueue? = nil,success: @escaping Success<JSON>, failure: Failure<MCError<MCErrorDetail>>? = nil) -> DataRequest {
        
        
        return Alamofire.request(url, method: .get,
                                 parameters: params,
                                 encoding: URLEncoding.default,
                                 headers: ["Content-Type":"application/json"])
            .responseJSON(queue: queue) { (response) in
                
                let result = response.result
                
                
                // 网络异常 没访问到服务器
                if result.isFailure {
                    if (failure != nil) {
                        failure!(.networkNull)
                    }
                }
                
                
                if response.result.isSuccess {
                    
                    // 有效的返回的数据
                    if let data = response.result.value as? [String:Any] {
                        
                        let code = data["code"] as? NSNumber ?? 0
                        let message = data["message"] as? String ?? ""
                        
                        
                        // 想要的返回的结果处理
                        if code.intValue == 10000 {
                            
                            let json = JSON(data)
                            success(json["data"])
                        } else {   // 异常的结果处理
                            let error = MCErrorDetail(code: code.stringValue,message: message)
                            
                            if (failure != nil) {
                                failure!(.codeError(error))
                            }
                        }
                        
                    } else {   // 异常的数据结构
                        
                        if (failure != nil) {
                            failure!(.wrongReturn)
                        }
                    }
                }
        }
    }

}
