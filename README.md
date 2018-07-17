# MCNetwork
封装的网络请求

### 一. 代码下载地址
[代码地址](https://github.com/mancongiOS/MCNetwork.git)

### 二. MCNetwork说明
*  集成了Alamofire和SwiftyJSON。请自行下载。
*  对错误的处理

```
enum MCError <T> {
case codeError(T)             // 异常的结果处理
case networkNull             // 网络异常 没访问到服务器
case networkBadReturn        // 异常的数据结构
}
```
* 调用方法的说明
```
public static func POST(_ url: String!, _ params:[String:Any]? = [String:Any](), _ queue:DispatchQueue? = nil,success: @escaping Success<JSON>, failure: Failure<MCError<MCErrorDetail>>? = nil) -> DataRequest { }
```
大部分情况下，只需要处理，理想返回的状态数据。所以单独用一个success闭包，传递出来JSON对象，外部不再需要考虑条件，直接处理数据即可。

有一些情况下需要处理，错误的服务器code返回情况，比如登录异常。把它集成在MCError这个枚举中。codeError这个case对应的是一个结构体，有两个属性code，和message

### 三. 使用
```
let url = ""
let params = [  "":""]

// 只处理成功的网络请求
MCNetwork.POST(url,params,success: { (data) in
// data为JSON类型。 注意SwiftyJSON的使用
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

// GET请求
MCNetwork.GET(url, params, nil, success: { (data) in

}) { (error) in

}

```
