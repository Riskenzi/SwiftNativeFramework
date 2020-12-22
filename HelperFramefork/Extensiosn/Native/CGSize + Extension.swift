//
//  CGSize + Extension.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import Foundation
import UIKit
extension CGSize {

    static func aspectFit(videoSize: CGSize, boundingSize: CGSize) -> CGSize {

        var size = boundingSize
        let mW = boundingSize.width / videoSize.width;
        let mH = boundingSize.height / videoSize.height;

        if( mH < mW ) {
            size.width = boundingSize.height / videoSize.height * videoSize.width;
        }
        else if( mW < mH ) {
            size.height = boundingSize.width / videoSize.width * videoSize.height;
        }

        return size;
    }

    static func aspectFill(videoSize: CGSize, boundingSize: CGSize) -> CGSize {

        var size = boundingSize
        let mW = boundingSize.width / videoSize.width;
        let mH = boundingSize.height / videoSize.height;

        if( mH > mW ) {
            size.width = boundingSize.height / videoSize.height * videoSize.width;
        }
        else if ( mW > mH ) {
            size.height = boundingSize.width / videoSize.width * videoSize.height;
        }

        return size;
    }
}


extension CGSize {
    static func aspectFit(videoSize: CGSize, boundingSize: CGSize, scale: CGFloat = 1.0) -> CGSize {

        var size = boundingSize
        let mW = boundingSize.width / videoSize.width;
        let mH = (boundingSize.height / videoSize.height) * scale

        if( mH < mW ) {
            size.width = boundingSize.height / videoSize.height * videoSize.width;
        }
        else if( mW < mH ) {
            size.height = boundingSize.width / videoSize.width * videoSize.height;
        }

        size.width = size.width * scale
        size.height = size.height * scale

        return size;
    }

    static func aspectFill(videoSize: CGSize, boundingSize: CGSize, scale: CGFloat) -> CGSize {

        var size = boundingSize
        let mW = boundingSize.width / videoSize.width;
        let mH = boundingSize.height / videoSize.height;

        if( mH > mW ) {
            size.width = (boundingSize.height / videoSize.height * videoSize.width) * scale;
        } else if ( mW > mH ) {
            size.height = (boundingSize.width / videoSize.width * videoSize.height) * scale;
        }

        return size;
    }
}
