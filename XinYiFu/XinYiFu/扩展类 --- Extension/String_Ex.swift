//
//  String_Ex.swift
//  UTOO
//
//  Created by Lenny on 16/9/24.
//  Copyright © 2016年 Lenny. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /**
     * 截取一段字符串 从开始到第几位结束
     * 例如 asdfghjkl （5）
     * 结果： asdfg
     **/
    func substringToIndex(index: Int) -> String {
        return String(self[self.startIndex..<self.index(self.startIndex, offsetBy: index)])
    }
    /**
     * 截取一段字符串 从第几位开始 到字符串的末尾结束
     * 例如 asdfghjkl （5）
     * 结果：hjkl
     */
    func substringFromIndex(index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)..<self.endIndex])
    }
    /**
     * 截取一段字符串 从第几位开始 到第几位结束
     * 例如 asdfghjkl （3 5 ）
     * 结果：fg
     */
    func substringWithRange(start: Int, end: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: start)..<self.index(self.startIndex, offsetBy: end)])
    }
    /**
     * 截取一段字符串 从第哪一位开始 到哪一位结束结束（不包括）
     * 例如 asdfghjkl （s k ）
     * 结果：dfgh
     */
    func substringWithNewRange(start: String, end: String) -> String {
        //截取的下界
        let rangIndex = self.range(of: end)
        let endIndex = rangIndex!.lowerBound
        //截取的上界
        let rangIndexA = self.range(of: start)
        let endIndexA = rangIndexA!.upperBound
        //截取的范围
        let result  = self[endIndexA ..< endIndex]
        return String(result)
    }
    
    
    func parasingWebStringToDic() -> Dictionary<String, String> {
        var dic = Dictionary<String, String>()
        let urlString = self as NSString
        let range = urlString.range(of: "?")
        if range.length > 0 {
            let locationString = urlString.substring(from: range.location + 1)
            let array = locationString.components(separatedBy: "&")
            array.forEach { (dicString) in
                let arr = dicString.components(separatedBy: "=")
                dic[arr.first ?? ""] = arr.last
            }
        }
        return dic
    }
    
    /**
     *
     * 根据文本计算高度
     *
     */
    func getTextRectSize(_ font:UIFont, size:CGSize) -> CGFloat {
        let attributes = [NSAttributedStringKey.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size.height;
    }

    
    func stringSize(font:UIFont)->CGSize {
        return self.stringSize(markSize: CGSize.init(width:CGFloat.greatestFiniteMagnitude , height: CGFloat.greatestFiniteMagnitude), font: font)
    }
    
    func stringSize(markSize:CGSize ,font:UIFont) -> CGSize {
        
        var str:NSString = self as NSString
        if str.integerValue < 10 {
            str = NSString.init(string: "0" + self)
        }
        let size = str.boundingRect(with: markSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil).size
        return size
    }
    
    /**
     *
     * 数字类型的字符串 转化为  NSNumber
     *
     */
    func stringToNSNumber() -> NSNumber {
        let str:NSString = self as NSString
        let num = NSNumber.init(value: str.floatValue)
        return num
    }
    
    func toDic() -> NSDictionary? {
        
        var jsonString = self
        jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        jsonString = jsonString.replacingOccurrences(of: " ", with: "")
        jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
        jsonString = jsonString.replacingOccurrences(of: "=", with: ":")
        jsonString = jsonString.replacingOccurrences(of: ";", with: ",")
        let data = jsonString.data(using: .utf8)
        guard let datas = data else {return nil}
        let dic = try? JSONSerialization.jsonObject(with: datas, options: JSONSerialization.ReadingOptions.mutableContainers)
        return dic as? NSDictionary ?? nil
    }
    func JSONtoDic() -> NSDictionary? {
        
        
        var jsonString = self
        jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let data = jsonString.data(using: .utf8)
        guard let datas = data else {return nil}
        let dic = try? JSONSerialization.jsonObject(with: datas, options: JSONSerialization.ReadingOptions.mutableContainers)
        return dic as? NSDictionary ?? nil
    }
    
    
    // 字符串转钱
//    func money() -> String {
//        return "￥" + String(format: "%.2f", isNull(self).stringToNSNumber().floatValue)
//    }
    // 字符串转int
    func stringToInt(str:String)->(Int){
        
        let string = str
        var int: Int?
        if let doubleValue = Int(string) {
            int = Int(doubleValue)
        }
        if int == nil
        {
            return 0
        }
        return int!
    }
    // 折扣
    func keepFloatPlaces(digit: Int) -> String {
        return ""
//        return String(format: "%.\(digit)f", isNull(self).stringToNSNumber().floatValue)
    }
//    func setAttributeString(str: String, border: Int, font: UIFont) {
//        let nameStr:NSMutableAttributedString = NSMutableAttributedString(string: str)
//        let range = NSMakeRange(0, border)
//        nameStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray, range: range)
//        let range2 = NSMakeRange(border, str.count-border)
//        nameStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.rgb(29, 68, 255), range: range2)
//        nameStr.addAttribute(NSAttributedStringKey.font, value: font, range: NSMakeRange(0, str.count))
//        setAttributeString(str: str, border: 5, font: UIFont.size12)
//    }
    
//    func idCardNumber() -> String {
//        var resultStr = ""
//        var index = 0
//        let strCount = self.characters.count
//        self.characters.forEach { (item) in
//            index += 1
//            if (index > 0 && index <= 3) || (index <= strCount && index > strCount - 3){
//                resultStr.append(item)
//            } else {
//                resultStr.append("*")
//            }
//        }
//        return resultStr
//    }
    
    // 格式化时间
    func time(dateFormat: String) -> String {
        
        let date = Date(timeIntervalSinceNow: TimeInterval(self) ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
    
    func timeSince1970(dateFormat: String) -> String {
        let date = Date.init(timeIntervalSince1970: TimeInterval(self) ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }

    /**   这个方法没有多大用，系统API已经提供了很多方法给我们如上
     *  URL 编码
     *   return 编码字符串
     */
//    func encodeEscapesURL(value: String) -> String {
//        let str:String = value
//        let originalString = str as CFString
//        let charactersToBeEscaped = "!*'();:@&=+$,/?%#[]" as CFString  //":/?&=;+!@#$()',*"    //转意符号
//        //let charactersToLeaveUnescaped = "[]." as CFStringRef  //保留的符号
//        let result =
//            CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                    originalString,
//                                                    nil,    //charactersToLeaveUnescaped,
//                charactersToBeEscaped,
//                CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)) as NSString
//        return result as String
//    }
    /**
     *  URL 解码
     *   return 解码字符串
     */
//    func stringByURLDecode() -> String {
//        if self.removingPercentEncoding != nil {
//            return self.removingPercentEncoding!
//        } else {
//            let en: CFStringEncoding = CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)
//            var decoded: String = self.replacingOccurrences(of: "+", with: " ")
//            decoded = (CFURLCreateStringByReplacingPercentEscapesUsingEncoding(nil, (decoded as CFString),nil, en) as String)
//            return decoded
//        }
//    }
    
    //验证手机号码
    func isMobile() -> Bool {
        let phoneRegex = "[1][23456789]\\d{9}"
        let tempPhone = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return tempPhone.evaluate(with: self)
    }
    //验证手机密码
    func isPassword() -> Bool {
        let phoneRegex = "^[A-Za-z0-9]{6,16}$"
        let tempPhone = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return tempPhone.evaluate(with: self)
    }
    /// 替换手机号中间四位
    ///
    /// - Returns: 替换后的值
    func replacePhone() -> String {
        let start = self.index(self.startIndex, offsetBy: 4)
        let end = self.index(self.startIndex, offsetBy: 14)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return self.replacingCharacters(in: range, with: "********")
    }
    
    func isStringNotEmpty() -> Bool {
        return count > 0
    }
}

extension String {
    func matchWithRegExp(_ pattern: String) -> Bool {
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return false
        }
        return regExp.firstMatch(in: self, options: .anchored, range: NSRange(location: 0, length: self.utf16.count)) != nil
    }
    
    var isValidPhoneNumber: Bool {
        return matchWithRegExp("^1\\d{10}$")
    }
    
    var isValidLoginPassword: Bool {
        return matchWithRegExp("^(?![0-9]+$)[0-9A-Za-z]{0,20}$")
    }
}

extension String {
    func encodingToURL() -> String {
        let urlString: NSString = self as NSString
        let range = urlString.range(of: "?")
        let mainString = urlString.substring(to: range.location + 1)
        var subString = urlString.substring(from: range.location + 1)
        subString = subString.replacingOccurrences(of: " ", with: "%20")
        subString = subString.replacingOccurrences(of: "/", with: "%2f")
        subString = subString.replacingOccurrences(of: "{", with: "%7B")
        subString = subString.replacingOccurrences(of: "[", with: "%5B")
        subString = subString.replacingOccurrences(of: "}", with: "%7D")
        subString = subString.replacingOccurrences(of: "]", with: "%5D")
        subString = subString.replacingOccurrences(of: ":", with: "%3A")
        return mainString + subString
    }
}

extension TimeInterval {
    func timeIntervalString() -> String {
        let day = Int(self / 3600 / 24)
        let hours = Int((self - Double(day) * 24 * 3600) / 3600)
        let minute = Int((self - Double(day) * 24 * 3600 - Double(hours) * 3600) / 60)
        
        let dayStr = String(format: "%02i", day)
        let hoursStr = String(format: "%02i", hours)
        let minuteStr = String(format: "%02i", minute)
        return dayStr + "天" + hoursStr + "时" + minuteStr + "分"
    }
}
