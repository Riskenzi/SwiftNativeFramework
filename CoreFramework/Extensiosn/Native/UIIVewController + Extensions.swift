//
//  UIIVewController + Extensions.swift
//  CoreSwift
//
//  Created by   Валерий Мельников on 19.01.2021.
//

import Foundation
import UIKit

// MARK: - Properties UIViewController's (static)
extension UIViewController {
    
    // MARK: - Static properties
    
    struct Holder {
        static var loaderAlert: UIAlertController = UIAlertController()
        static var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    }
    
    var loaderAlert: UIAlertController {
        get {
            return Holder.loaderAlert
        }
        set(newValue) {
            Holder.loaderAlert = newValue
        }
    }
    
    var loadingIndicator: UIActivityIndicatorView {
        get {
            return Holder.loadingIndicator
        }
        set(newValue) {
            Holder.loadingIndicator = newValue
        }
    }
    
    // MARK: - Actions
    
    func showLoader(_ message: String) {
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {
                return
            }
            self.loaderAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            self.loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            self.loadingIndicator.hidesWhenStopped = true
            self.loadingIndicator.style = .medium
            self.loadingIndicator.startAnimating()
            
            self.loaderAlert.view.addSubview(self.loadingIndicator)
            self.present(self.loaderAlert, animated: true, completion: nil)
            
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.isUserInteractionEnabled = false
            } else {
                UIApplication.shared.beginIgnoringInteractionEvents()
            }
        }
        
    }
    
    func hideLoader() {
        
        DispatchQueue.main.async { [weak self] in
            self?.loaderAlert.dismiss(animated: true, completion: nil)
            self?.loadingIndicator.stopAnimating()
            
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.isUserInteractionEnabled = true
            } else {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
        
    }
    
    func showEmptyView(_ message: String = "", imageName: String = "photo_image") {
        if(emptyImageView == nil) {
            _ = initEmptyImageView()
        }
        emptyImageView?.image = UIImage(named: imageName)
        
        if(emptyLabel == nil) {
            _ = initEmptyLabel()
        }
        
        let attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 21)]
        let boldString = NSAttributedString(string: message, attributes:attrs)
        emptyLabel?.attributedText = boldString
        
        emptyImageView?.isHidden = false
        emptyLabel?.isHidden = false
        
        view.bringSubviewToFront(emptyImageView!)
        view.bringSubviewToFront(emptyLabel!)
    }
    
    func hideEmptyView() {
        DispatchQueue.main.async { [weak self] in
            self?.emptyImageView?.isHidden = true
            self?.emptyLabel?.isHidden = true
        }
    }
}
fileprivate extension UIViewController {
    
    // MARK: - Associated Keys
    
    private struct AssociatedKeys {
        static var kEmptyImageView = "key_emptyImageView"
        static var kEmptyLabel = "key_emptyLabel"
    }
    
    private var emptyImageView: UIImageView? {
        get {
            guard let imgView = objc_getAssociatedObject(self, &AssociatedKeys.kEmptyImageView) as? UIImageView else {
                return initEmptyImageView()
            }
            
            return imgView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.kEmptyImageView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    private var emptyLabel: UILabel? {
        get {
            guard let label = objc_getAssociatedObject(self, &AssociatedKeys.kEmptyLabel) as? UILabel else {
                return initEmptyLabel()
            }
            
            return label
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.kEmptyLabel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    // MARK: - Init dynamic properties
    
    private func initEmptyImageView() -> UIImageView {
        let _emptyImageView = UIImageView(frame: .init(origin: .zero, size: .init(width: 60, height: 60)))
        _emptyImageView.contentMode = .scaleAspectFit
        _emptyImageView.tintColor = .clear
        _emptyImageView.image = UIImage(named: "empty_table")
        _emptyImageView.center = view.center
        
        // Add to view
        
        view.addSubview(_emptyImageView)
        
        _emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        _emptyImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        _emptyImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        _emptyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        _emptyImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.frame.size.height - view.frame.size.height * 0.8)).isActive = true
        
        view.layoutIfNeeded()
        
        // Remind
        
        emptyImageView = _emptyImageView
        
        return _emptyImageView
    }
    
    private func initEmptyLabel() -> UILabel {
        let _emptyLabel = UILabel()
        _emptyLabel.numberOfLines = 0
        _emptyLabel.textColor = .darkText
        _emptyLabel.textAlignment = .center
        
        // Add to view
        
        view.addSubview(_emptyLabel)
        
        _emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        _emptyLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 21.0).isActive = true
        _emptyLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 140.0).isActive = true
        _emptyLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16).isActive = true
        _emptyLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 16).isActive = true
        
        _emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        _emptyLabel.topAnchor.constraint(equalTo: emptyImageView!.bottomAnchor, constant: 16).isActive = true
        
        view.layoutIfNeeded()
        
        // Remind
        
        emptyLabel = _emptyLabel
        
        return _emptyLabel
    }
}

