//
//  UIColorManager.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 18.12.2020.
//

import UIKit

@available(iOS 14.0, *)

public protocol ColorPickerDelegate: class {
    func didSelect(_ color: UIColor?)
    func didFinish(_ color: UIColor?, _ isSelected : Bool)
}

@available(iOS 14.0, *)
open class UIColorManager: NSObject {
    private var pickerController = UIColorPickerViewController()
    private weak var presentationController: UIViewController?
    private weak var delegate: ColorPickerDelegate?
    // Global declaration, to keep the subscription alive.
    public init(presentationController: UIViewController, delegate: ColorPickerDelegate) {
        self.pickerController = UIColorPickerViewController()
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.selectedColor = .clear
        
    }
    private func pickerController(_ controller : UIColorPickerViewController, didSelect color: UIColor?) {
        controller.dismiss(animated: true)
        self.delegate?.didSelect(color)
    }
    
    private func pickerControllerFinish(_ controller : UIColorPickerViewController, didSelect color: UIColor?) {
        if !compareColors(c1: color ?? .clear, c2: UIColor.clear) {
            self.delegate?.didFinish(color, true)
        }else {
            self.delegate?.didFinish(color, false)
        }
        
    }
    
    public func present() {
        self.presentationController?.modalPresentationStyle = .fullScreen
        self.presentationController?.present(pickerController, animated: true)
    }
    
    
   private  func compareColors (c1:UIColor, c2:UIColor) -> Bool{
        // some kind of weird rounding made the colors unequal so had to compare like this

        var red:CGFloat = 0
        var green:CGFloat  = 0
        var blue:CGFloat = 0
        var alpha:CGFloat  = 0
        c1.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        var red2:CGFloat = 0
        var green2:CGFloat  = 0
        var blue2:CGFloat = 0
        var alpha2:CGFloat  = 0
        c2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        return (Int(red*255) == Int(red*255) && Int(green*255) == Int(green2*255) && Int(blue*255) == Int(blue*255) )


    }
}

@available(iOS 14.0, *)
extension UIColorManager : UIColorPickerViewControllerDelegate {
    public func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        pickerController(viewController, didSelect: viewController.selectedColor)
        self.pickerController.dismiss(animated: true)
    }
    
    public func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        pickerControllerFinish(viewController, didSelect: viewController.selectedColor)
    }
}
