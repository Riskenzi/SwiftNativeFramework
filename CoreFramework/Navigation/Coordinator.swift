//
//  Coordinator.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 01.12.2020.
//

import UIKit

open class Coordinator: NSObject {
    
    static func getRootViewController() -> UIViewController? {
        var rootViewController: UIViewController?
        if #available(iOS 13.0, *) {
            // iOS 13 (or newer) Swift code
            rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        } else {
            // iOS older code
            rootViewController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        return rootViewController
    }
    
    public static func getVisibleViewController(_ rootViewController: UIViewController) -> UIViewController? {
        
        if let presentedViewController = rootViewController.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }
        
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.visibleViewController
        }
        
        if let tabBarController = rootViewController as? UITabBarController {
            return tabBarController.selectedViewController
        }
        
        return rootViewController
    }
    
//    static func navigateConfingurate(in navigationController: UINavigationController, _ mode : AppConfig.ConfigMode) -> Void {
//        
//        let controller = ConfigViewController(nibName: UINib.configurateController, bundle: nil)
//        controller.modalPresentationStyle = .fullScreen
//        controller.viewMode = mode
//        navigationController.show(controller, sender: nil)
//    }
    
//    static func navigateRecordings(in navigationController: UINavigationController) -> Void {
//
//        let controller = RecordsController(nibName: UINib.recordsController, bundle: nil)
//        controller.modalPresentationStyle = .fullScreen
//        navigationController.show(controller, sender: nil)
//    }
//
//    static func navigateSettings(in navigationController: UINavigationController) -> Void {
//
//        let controller = SettingsController(nibName: UINib.settingsController, bundle: nil)
//        controller.modalPresentationStyle = .fullScreen
//        navigationController.show(controller, sender: nil)
//    }
//
//    static func navigatePlayer(in navigationController: UINavigationController, file : VideoFile? = nil) -> Void {
//
//        let controller = PlayerController(nibName: UINib.playerController, bundle: nil)
//        controller.modalPresentationStyle = .fullScreen
//        controller.videoFile = file
//        navigationController.show(controller, sender: nil)
//    }
//
//    static func navigateEditor(in navigationController: UINavigationController, _ mode : AppConfig.EditMode = .unowned, file : VideoFile? = nil) -> Void {
//
//        let controller = EditorController(nibName: UINib.editorController, bundle: nil)
//        controller.modalPresentationStyle = .fullScreen
//        controller.viewMode = mode
//        controller.videoFile = file
//        navigationController.show(controller, sender: nil)
//    }
}
