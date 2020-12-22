//
//  UIFont+Extensions.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import UIKit

extension UIFont {
    
    /// Create **extension** for this enum to add cases with **new fonts**.
    ///
    /// ** Extension example**
    /// ```
    /// extension UIFont.FontFamily {
    ///     enum Myriad: String {
    ///         case myriadBold = "MiradBold"
    ///         case myriadPro = "MiradPro"
    ///     }
    /// }
    /// ```
    enum FontFamily: String {
        case systemRegular = "a"
    }
    
    
    /// Generate custom UIFont.
    /// - Parameters:
    ///   - size: font size in `px`.
    ///   - fontFamily: enum `FontFamily` or extended property.
    /// - Returns: IFont from name.
    static func customFont(_ size: CGFloat = 16.0,
                               _ fontFamily: FontFamily) -> UIFont {
        return UIFont(name: "fontFamily.rawValue", size: size)!
    }
    
}
