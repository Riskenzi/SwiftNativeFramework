//
//  MethodCore.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 02.12.2020.
//
import Foundation
import UIKit

open class MethodCore: NSObject {
    static func showAlertSingle(_ title: String, _ message: String? = nil) -> Void {
        
        guard let rootVC = Coordinator.getRootViewController(),
            let visableController = Coordinator.getVisibleViewController(rootVC) else {
                print("🤷🏼‍♀️ Root ViewController or VisableController didn't found.")
                return
        }
      
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        visableController.present(ac, animated: true, completion: nil)
    }
    
    public static func showAlertWithActions(_ title: String, _ message: String,buttonTitle : String,buttonSave: @escaping (_ action: Bool) -> Void) {
        
        guard let rootVC = Coordinator.getRootViewController(),
              let visableController = Coordinator.getVisibleViewController(rootVC) else {
            print("🤷🏼‍♀️ Root ViewController or VisableController didn't found.")
            return
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        ac.addAction(UIAlertAction(title: buttonTitle , style: .default, handler: { (action) in
            buttonSave(true)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:  {(action) in
            buttonSave(false)
        }))
        
        visableController.present(ac, animated: true, completion: nil)
    }
    
}
