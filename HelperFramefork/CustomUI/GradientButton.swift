//
//  GradientButton.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import UIKit
open class GradientButton: UIButton {

    open  override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.colors = [UIColor.colorGradientFirst_Button.cgColor,UIColor.colorGradientSecond_Button.cgColor]
        l.locations = [0,1]
        l.startPoint = CGPoint(x: 1.0, y: 0.45)
        l.endPoint = CGPoint(x:  0.25, y: 1.0)
        l.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        l.position = self.center
        l.cornerRadius = 10
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
