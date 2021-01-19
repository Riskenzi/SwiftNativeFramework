//
//  CustomAlertView.swift
//  FingerMap
//
// Created by Maksym Tokhtaryts on 12.01.2021.
//

import Foundation
import UIKit
protocol AlertViewModel {
    
    func show(animated: Bool)
    func dismiss(animated: Bool)
    var backgroundView: UIView {get set}
    var containerView: UIView {get set}
}


enum AnimationOption: Int {
    case zoomInOut
}

extension AlertViewModel where Self: UIView {
    
    func show(animated: Bool) {
        self.backgroundView.alpha = 0
        
        if let root = Coordinator.getRootViewController(){
            if let visable = Coordinator.getVisibleViewController(root){
                let subviewsList = visable.view.subviews
                for view in subviewsList where view is AlertView {
                    view.removeFromSuperview()
                    break
                }
                visable.view.addSubview(self)
            }
        }
        
        if animated {
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.25, animations: {
                self.backgroundView.alpha = 1.0
                self.containerView.transform = .identity
            }, completion: { (_) in
                self.backgroundView.alpha = 1.0
                
            })
        }
    }
    
    func dismiss(animated: Bool) {
        if animated {
            self.backgroundView.alpha = 1.0
            self.containerView.transform = .identity
            UIView.animate(withDuration: 0.11, animations: {
                self.backgroundView.alpha = 0.0
                self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { (_) in
                self.backgroundView.alpha = 0.0
                self.removeFromSuperview()
            })
        } else {
            self.backgroundView.alpha = 0.0
            self.removeFromSuperview()
        }
    }
}
//extension ViewController: AlertViewDelegate {
//    func alertView(alertView: AlertView, clickedButtonAtIndex buttonIndex: Int) {
//        
//    }
//
//}
