//
//  PlayerView.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import Foundation
import UIKit
import AVFoundation

open class PlayerView: UIView {
    var player: AVPlayer? {
        get {
           // playerLayer.videoGravity = AVLayerVideoGravity.resize
            return playerLayer.player
        }
        
        set {
            //playerLayer.videoGravity = AVLayerVideoGravity.resize
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        //playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return layer as! AVPlayerLayer
//        let playerLayer = AVPlayerLayer()
//        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        return playerLayer
        
    }
 
    open override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
