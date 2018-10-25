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
//let Moya_baseURL = "http://app.u17.com/v3/appV3_3/ios/phone"
//本地环境
//let Moya_baseURL = "http://192.168.1.211:9090/TMP"
//let Moya_baseURL = "http://192.168.1.211:9999/TMP"
//线上环境
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
    case getDoctorStatus
    //上传头像
    case uploadHeadImage(imageDate:Data)
    //上传多张图像
    case upSomeImage(text:String,imageArray:NSArray)
    //修改昵称
    case upniceName(text:String)
    //意见反馈
    case feedBack(text:String,imageArray:NSArray)
    //修改密码
    case setNewPassWord(phont:String,password:String,passwordConfirm:String,yzm:String)
    //获取验证码接口
    case getSmsYzm(phone:String)
    //同步医师数据
    case syncDoctorData
    //获取医生签名数据列表
    case getDoctorSignData(patientName:String,status:String,businessType:String,currentPage:Int,rows:Int)
    //拒绝签名
    case refuseSign(businessType:String,id:String,reason:String,refuseMarks:String)
    /***🐑 签名数据详情 🐑**/
    case signDataDetail(businessType:String,id:String)
    //签名成功签章查看
    case signedStamp(signedStr:String)
    //签名成功状态获取
    case signLlsok(businessType:String,id:String)
    //签名数据统计
    case signDataCount
    case searchHot//搜索热门
    case searchRelative(inputText: String)//相关搜索
    case searchResult(argCon: Int, q: String)//搜索结果
    
    case boutiqueList(sexType: Int)//推荐列表
    case special(argCon: Int, page: Int)//专题
    case vipList//VIP列表
    case subscribeList//订阅列表
    case rankList//排行列表
    
    case cateList//分类列表
    
    case comicList(argCon: Int, argName: String, argValue: Int, page: Int)//漫画列表
    
    case guessLike//猜你喜欢
    
    case detailStatic(comicid: Int)//详情(基本)
    case detailRealtime(comicid: Int)//详情(实时)
    case commentList(object_id: Int, thread_id: Int, page: Int)//评论
    
    case chapter(chapter_id: Int)//章节内容
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
        //获取医生账号状态 审核状态 已下载证书 已设置签章
        case.getDoctorStatus:return "/rest/appApi/getDoctorStatus"
        //上传头像
        case .uploadHeadImage: return "/rest/appApi/doctorPortrait"
        //上传多张图片
        case .upSomeImage: return "search/hotkeywordsnew"
        //修改昵称
        case .upniceName: return "/rest/appApi/updateNickName"
        //意见反馈
        case .feedBack: return "/rest/appApi/feedBack"
        //修改密码
        case .setNewPassWord:return  "/rest/appApi/setNewPassword"
        case .getSmsYzm:return "/rest/appApi/getSmsYzm"
        //获取医生签名数据列表
        case .getDoctorSignData:return "/rest/appApi/getDoctorSignData"
            /***🐑 签名数据详情 🐑**/
        case .signDataDetail:return "/rest/appApi/signDataDetail"
            /***🐑 拒绝签名 🐑**/
        case .refuseSign:return "/rest/appApi/refuseSign"
        //同步医师数据
        case .syncDoctorData:return "/rest/appApi/syncDoctorData"
        //签名成功签章查看
        case .signedStamp:return "/rest/appApi/signedStamp"
        //签名成功状态获取
        case .signLlsok:return "/rest/appApi/signIsok"
        //签名数据统计
        case .signDataCount:return "/rest/appApi/signDataCount"
            
            
            
        case .searchHot: return "search/hotkeywordsnew"
        case .searchRelative: return "search/relative"
        case .searchResult: return "search/searchResult"
            
        case .boutiqueList: return "comic/boutiqueListNew"
        case .special: return "comic/special"
        case .vipList: return "list/vipList"
        case .subscribeList: return "list/newSubscribeList"
        case .rankList: return "rank/list"
            
        case .cateList: return "sort/mobileCateList"
            
        case .comicList: return "list/commonComicList"
            
        case .guessLike: return "comic/guessLike"
            
        case .detailStatic: return "comic/detail_static_new"
        case .detailRealtime: return "comic/detail_realtime"
        case .commentList: return "comment/list"
            
        case .chapter: return "comic/chapterNew"
        }
    }
    /***👋 请求方式 是get 还是 post 👋**/
    //    **👋 这里写的是不同的请求方式 的实例 👋*
    var method: Moya.Method {
        return .post
    }
    
    
    /***👋 参数设置 👋**/
    var task: Task {
        var parmeters = ["time": Int32(Date().timeIntervalSince1970),
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
        //获取医生账号状态 审核状态 已下载证书 已设置签章
        case .getDoctorStatus:
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
            //获取待签列表
            /***👋 status 0 未同步 1 已同步 2已签名 3已拒绝 4已删除  👋**/
            /***👋 businessType:数据业务类型  目前只有会诊(hz)和门诊(mz)   👋**/
        case .getDoctorSignData(let patientName, let status,  let businessType,let currentPage,let rows):
            parmeter["patientName"] = patientName
            parmeter["status"] = status
            parmeter["businessType"] = businessType
            parmeter["currentPage"] = currentPage
            parmeter["rows"] = rows
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
        //上传头像
        case .uploadHeadImage(let iamgeData):
            let formData = MultipartFormData(provider: .data(iamgeData), name: "multipartFile",
                                             fileName: "hangge.png", mimeType: "file")
            return .uploadCompositeMultipart([formData], urlParameters: parmeter)
            /***👋 上传多张图片 👋**/
        case .upSomeImage(let text, let imageArray):
            parmeters["text"] = text
            let formDataAry:NSMutableArray = NSMutableArray()
            for (index,image) in imageArray.enumerated() {
                let data:Data = UIImageJPEGRepresentation(image as! UIImage, 0.9)!
                let date:Date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
                var dateStr:String = formatter.string(from: date as Date)
                dateStr = dateStr.appendingFormat("-%i.png", index)
                let formData = MultipartFormData(provider: .data(data), name: "file", fileName: dateStr, mimeType: "image/jpeg")
                formDataAry.add(formData)
            }
            printLog(formDataAry)
            return .uploadCompositeMultipart(formDataAry as! [MultipartFormData], urlParameters: parmeters)
        //修改用户昵称
        case .upniceName(let nickName):
            parmeter["nickName"] = nickName
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
        //意见反馈
        case .feedBack(let text, let imageArray):
            parmeter["fbContent"] = text
            let formDataAry:NSMutableArray = NSMutableArray()
            for (index,image) in imageArray.enumerated() {
                let data:Data = UIImageJPEGRepresentation(image as! UIImage, 0.9)!
                let date:Date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
                var dateStr:String = formatter.string(from: date as Date)
                dateStr = dateStr.appendingFormat("-%i.png", index)
                let formData = MultipartFormData(provider: .data(data), name: "multipartFile", fileName: dateStr, mimeType: "file")
                formDataAry.add(formData)
            }
            printLog(formDataAry)
            return .uploadCompositeMultipart(formDataAry as! [MultipartFormData], urlParameters: parmeter)
            
        case .setNewPassWord(let phont,let  password,let  passwordConfirm, let yzm):
            parmeter["phone"] = phont
            parmeter["passowrd"] = password
            parmeter["passowrdConfirm"] = passwordConfirm
            parmeter["yzm"] = yzm
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
        //获取验证码
        case .getSmsYzm(let phone):
            parmeter["phone"] = phone
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
            /***🐑 签名数据详情 🐑**/
        case .signDataDetail(let businessType,let id):
            parmeter["businessType"] = businessType
            parmeter["id"] = id
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
            
            /***🐑 拒绝签名 🐑**/
        case .refuseSign(let businessType,let id,let  reason,let refuseMarks):
            parmeter["businessType"] = businessType
            parmeter["id"] = id
            parmeter["reason"] = reason
            parmeter["refuseMarks"] = refuseMarks
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
        //同步医师数据
        case .syncDoctorData:
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
        //签名成功签章查看
        case .signedStamp(let signedStr):
            parmeter["signedStr"] = signedStr
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
        //签名数据统计
        case .signDataCount:
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
        case .signLlsok( let businessType,  let id):
            parmeter["businessType"] = businessType
            parmeter["id"] = id
            return .requestParameters(parameters: parmeter, encoding: URLEncoding.default)
            
        case .searchRelative(let inputText):
            parmeters["inputText"] = inputText
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .searchResult(let argCon, let q):
            parmeters["argCon"] = argCon
            parmeters["q"] = q
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .boutiqueList(let sexType):
            parmeters["sexType"] = sexType
            parmeters["v"] = 3320101
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .special(let argCon,let page):
            parmeters["argCon"] = argCon
            parmeters["page"] = max(1, page)
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .cateList:
            parmeters["v"] = 2
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .comicList(let argCon, let argName, let argValue, let page):
            parmeters["argCon"] = argCon
            if argName.count > 0 { parmeters["argName"] = argName }
            parmeters["argValue"] = argValue
            parmeters["page"] = max(1, page)
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .detailStatic(let comicid),
             .detailRealtime(let comicid):
            parmeters["comicid"] = comicid
            parmeters["v"] = 3320101
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .commentList(let object_id, let thread_id, let page):
            parmeters["object_id"] = object_id
            parmeters["thread_id"] = thread_id
            parmeters["page"] = page
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .chapter(let chapter_id):
            parmeters["chapter_id"] = chapter_id
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        }
    }
    /***👋  /// 这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用 👋**/
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    //头文件
    var headers: [String : String]? {
        switch self {
        case .login,.getSmsYzm:
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












