//
//  VerticalProgressView.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import Foundation
import UIKit

open class VerticalProgressView: UIView {
    // MARK: - Private Variables
    private var backgroundImage : UIView!
    private var progressView : UIImageView!
    private let animationDuration : Double = 0.6
    
    // MARK: - Overriden Methods
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initBar()
    }
    
     func intrinsicContentSize() -> CGSize {
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    // MARK: - Public Methods
    /**
     */
    func initBar() {
        
        self.layer.cornerRadius = frame.size.width / 2
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
        
        
        let backgroundRect = CGRect(x: 0.0, y: 0.0, width: Double(frame.size.width), height: Double(frame.size.height))
        backgroundImage = UIView(frame: backgroundRect)
        backgroundImage.clipsToBounds = true
        backgroundImage.backgroundColor = UIColor.yellow
        addSubview(backgroundImage)

      
        let progressRect = CGRect(x: 0.0, y: Double(frame.size.height), width: Double(frame.size.width), height: 0.0)
        progressView = UIImageView(frame: progressRect)
        progressView.layer.cornerRadius = frame.size.width / 2
        progressView.layer.masksToBounds = true
        
        progressView.backgroundColor = UIColor.blue
        addSubview(progressView)
    }
 
    func setProgressValue(currentValue : CGFloat , threshold  : CGFloat = 100.0) {
        let yOffset = ((threshold - currentValue) / threshold) * frame.size.height / 1
        UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.frame.size.height = self.frame.size.height - yOffset
            self.progressView.frame.origin.y = yOffset
        }, completion: nil)
    }
  
    func setBackColor(color : UIColor) {
        backgroundImage.backgroundColor = color
    }
  
    func setProgressColor(color : UIColor) {
        progressView.backgroundColor = color
    }
}
