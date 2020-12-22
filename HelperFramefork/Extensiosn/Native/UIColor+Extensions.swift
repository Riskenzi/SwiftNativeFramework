//
//  UIColor+Extensions.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var chars = Array(hex.hasPrefix("#") ? hex.dropFirst() : hex[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
    
    static public let colorGradientFirst_Button : UIColor = UIColor.init(hex: "#FF00B8")!
    static public let colorGradientSecond_Button : UIColor = UIColor.init(hex: "#FF4D00")!
}
