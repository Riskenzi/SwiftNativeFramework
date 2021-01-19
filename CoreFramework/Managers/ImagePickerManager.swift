//
//  ImagePickerManager.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import Foundation
import UIKit



public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

public enum statusPresent {
    case openCamera
    case chooseFromGallery
}

open  class ImagePickerManager: NSObject {
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
        
    }
    
    
    public func present(pickerStatus : statusPresent) {
        
        switch pickerStatus {
        case .openCamera:
            pickerController.delegate = self
            pickerController.sourceType = .camera
            pickerController.allowsEditing = false
            pickerController.modalPresentationStyle = .fullScreen
            self.presentationController?.present(pickerController, animated: true)
            self.presentationController?.modalPresentationStyle = .fullScreen
        case .chooseFromGallery:
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            pickerController.modalPresentationStyle = .fullScreen
            pickerController.allowsEditing = false
            
            self.presentationController?.modalPresentationStyle = .fullScreen
            self.presentationController?.present(pickerController, animated: true)
        }
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelect(image: image)
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePickerManager: UINavigationControllerDelegate {
    
}
