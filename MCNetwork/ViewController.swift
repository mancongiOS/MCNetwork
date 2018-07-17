//
//  ViewController.swift
//  MCNetwork
//
//  Created by MC on 2018/7/13.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(showLabel)
        
 
        

        
        
        
        
        
        
        let url = "http://api.hm2019.com/yg_huimeiapp/systemBizConfig/getCaption"

        let params = [  "code":"notice_picture",
                        "type":"notice"]


        weak var weakSelf = self


        MCNetwork.GET(url, params, nil, success: { (data) in
            weakSelf?.showLabel.text = "\(data)"
        }) { (error) in
            weakSelf?.showLabel.text = "\(error)"
        }
        
        
        // 只处理成功的网络请求
        MCNetwork.POST(url,params,success: { (data) in
            // 注意SwiftyJSON的使用
            weakSelf?.showLabel.text = data["value"].stringValue
        })




        // 处理非成功的网络请求。
        MCNetwork.POST(url, ["":""], nil, success: { (data) in

        }) { (error) in

            switch error {
            case .codeError(let codeError):
                weakSelf?.showLabel.text = "\(codeError.message) + \(codeError.code)"
            case .networkNull:
                weakSelf?.showLabel.text = "networkNull"
            case .wrongReturn:
                weakSelf?.showLabel.text = "wrongReturn"
            }
        }





        // 网络请求成功和失败一起处理。
        MCNetwork.POST(url, params, nil, success: { (data) in

            weakSelf?.showLabel.text = "\(data)"
        }) { (error) in

        }
        
        
        // GET请求
        MCNetwork.GET(url, params, nil, success: { (data) in
            
        }) { (error) in
            
        }
        
    }
    
    
    lazy var showLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.red
        label.frame = self.view.frame
        label.numberOfLines = 0
        label.backgroundColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.center
        return label
    }()
}

