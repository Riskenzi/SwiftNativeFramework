//
//  UIView+Extensions.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import UIKit

extension UIView {
    
    // MARK@objc @objc @objc : - Generate Identifier
    
    class var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Generate views block
    
    /// Generate small view which will contans image view.
    /// - Parameters:
    ///   - image: image will be displaying.
    ///   - imgTinColor: render image with mode template with tintColor.
    /// - Returns: UIImageView inside UIView. UIImageView size 20x20 px. UIView size 30x30.
    public func textFieldLeftView(_ image: UIImage, imgTinColor: UIColor) -> UIView {
        let leftContainer : UIView = .init(frame: .init(x: 0, y: 0, width: 30, height: 30))
        leftContainer.backgroundColor = .clear
        
        let imgView : UIImageView = .init(frame: .init(x: 5, y: 5, width: 20, height: 20))
        imgView.backgroundColor = .clear
        imgView.tintColor = imgTinColor
        
        imgView.contentMode = .scaleAspectFit
        imgView.image = image.withRenderingMode(.alwaysTemplate)
        
        leftContainer.addSubview(imgView)
        
        leftContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        leftContainer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return leftContainer
    }
    
    // MARK: - Appearances
    
    public func makeRoundView(_ cornerRadius: CGFloat) -> Void {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
    
    public func makeShadowView(_ shadowRadius: CGFloat) -> Void {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = shadowRadius
    }
    
}
extension UIView {
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        transform = transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    func showAnimtionBottomToTop(){
        
        UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseInOut],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.alpha = 1
                        self.transform = CGAffineTransform.identity
                        self.layoutIfNeeded()
                       }, completion: nil)
        // self.isHidden = false
        
    }
    
    func animHide(){
        UIView.animate(withDuration: 0.35, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.alpha = 0
                        self.transform = CGAffineTransform.identity
                        self.layoutIfNeeded()
                        
                       },  completion: {(_ completed: Bool) -> Void in
                        //self.isHidden = true
                       })
    }
    
    
    func saveAsImage()-> UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        UIColor.clear.set()
        context.fill(self.bounds)
        
        self.isOpaque = false
        self.layer.isOpaque = false
        self.backgroundColor = UIColor.clear
        self.layer.backgroundColor = UIColor.clear.cgColor
        
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }
}
extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}
