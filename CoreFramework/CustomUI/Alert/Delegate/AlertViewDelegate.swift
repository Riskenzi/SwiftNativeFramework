//
//  AlertProtocol.swift
//  FingerMap
//
// Created by Maksym Tokhtaryts on 12.01.2021.
//


import Foundation
import UIKit
@objc protocol AlertViewDelegate: class {
    @objc optional func alertView(alertView: AlertView, clickedButtonAtIndex buttonIndex: Int)
}
