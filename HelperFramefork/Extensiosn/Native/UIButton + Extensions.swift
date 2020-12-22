//
//  UIButton + Extensions.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import Foundation
import UIKit

extension UIButton {
    
    public func makeRoundButton(_ cornerRadius: CGFloat) -> Void {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
    
    func anim(){
        UIView.animate(withDuration: 1.35, delay: 0, options: [.curveEaseInOut],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.alpha = 1
                        self.transform = CGAffineTransform.identity
                        self.layoutIfNeeded()
                       }, completion: nil)
        self.isHidden = false
    }
}
