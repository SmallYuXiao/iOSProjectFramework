//
//  UAPI.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import Moya
import HandyJSON
import MBProgressHUD
import SwiftyJSON
/***👋 baseURL 👋**/
let Moya_baseURL = "http://47.106.161.7:9999/TMP"
/***👋 管理网络状态的插件 👋**/
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        /***👋 网络开始请求的时候 旋转  👋**/
        //        MBProgressHUD.hide(for: vc.view, animated: false)
        //        MBProgressHUD.showAdded(to: vc.view, animated: true)
        Window?.hidAllHud()
        Window?.showLoading()
    case .ended:
        /***👋 网络请求结束的时候 取消loding 👋**/
        Window?.hidAllHud()
        //        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<UApi>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        /***🐑 设置网络请求时间 🐑**/
        urlRequest.timeoutInterval = 20
        // 打印请求参数
        if let requestData = urlRequest.httpBody {
            printLog("\(urlRequest.url!)"+"\n"+"\(urlRequest.httpMethod ?? "")"+"发送参数"+"\(String(data: urlRequest.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            printLog("\(urlRequest.url!)"+"\(String(describing: urlRequest.httpMethod))")
        }
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}
/***👋 于是Moya提供一个发送请求的Provider 这里没有插件👋**/
let ApiProvider = MoyaProvider<UApi>(requestClosure: timeoutClosure)
/***👋 这里可以自定义一个插件 loding插件 👋**/
let ApiLoadingProvider = MoyaProvider<UApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

enum UApi {
    // 账号密码登录
    case login(phontNumber:String,passwdNumber:String)
    //
 
}

extension UApi: TargetType {
    private struct UApiKey {
        
        static var key = "fabe6953ce6a1b8738bd2cabebf893a472d2b6274ef7ef6f6a5dc7171e5cafb14933ae65c70bceb97e0e9d47af6324d50394ba70c1bb462e0ed18b88b26095a82be87bc9eddf8e548a2a3859274b25bd0ecfce13e81f8317cfafa822d8ee486fe2c43e7acd93e9f19fdae5c628266dc4762060f6026c5ca83e865844fc6beea59822ed4a70f5288c25edb1367700ebf5c78a27f5cce53036f1dac4a776588cd890cd54f9e5a7adcaeec340c7a69cd986:::open"
    }
    
    var baseURL: URL { return URL(string: Moya_baseURL)! }
    /***👋 请求网址 👋**/
    var path: String {
        switch self {
        //登录
        case .login: return "/rest/appApi/appLogin"

        }
    }
    /***👋 请求方式 是get 还是 post 👋**/
    //    **👋 这里写的是不同的请求方式 的实例 👋*
    var method: Moya.Method {
        return .post
    }
    
    
    /***👋 参数设置 👋**/
    var task: Task {
        let parmeters = ["time": Int32(Date().timeIntervalSince1970),
                         "device_id": UIDevice.current.identifierForVendor!.uuidString,
                         "key": UApiKey.key,
                         "model": UIDevice.current.modelName,
                         "target": "U17_3.0",
                         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
        var parmeter: [String: Any] = [:]
        switch self {
        case .login(let phontNumber,let passwdNumber):
            parmeter["username"] = phontNumber
            parmeter["password"] = passwdNumber
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        }
    }
    /***👋  /// 这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用 👋**/
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    //头文件
    var headers: [String : String]? {
        switch self {
        case .login:
            return nil
        default:
            let NewToken =  UserDefaults.standard.object(forKey: "token") ?? ""
            return ["X-AUTH-TOKEN": NewToken as! String]
        }
    }
    //    var headers: [String : String]? { return nil }
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}
/***🐑 这个返回的是model 🐑**/
extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        return request(target, completion: { (result) in
            switch result{
            case let .success(response):
                do {
                    let jsonData = try JSON(data: response.data)
                    printLog(jsonData)
                } catch {
                }
            case .failure(_):
                Window?.showHUD("网络连接失败")
            }
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            if returnData?.respCode == "-1"{
                let message = returnData?.message
                Window?.showHUD(message)
            }else if returnData?.respCode == "-2"{
                let message = returnData?.message
                Window?.showHUD(message)
            }
            completion(returnData?.data)
            
        })
    }
}












