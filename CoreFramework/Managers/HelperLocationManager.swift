//
//  HelperLocationManager.swift
//  FingerMap
//
// Created by Maksym Tokhtaryts on 04.01.2021.
//

import UIKit
import CoreLocation
import AddressBookUI

class HelperLocationManager: NSObject {
    
    fileprivate  lazy var locationManager = CLLocationManager()
    static let sharedInstance = HelperLocationManager()
    let nc = NotificationCenter.default
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
}

extension HelperLocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        
        case CLAuthorizationStatus.notDetermined:
            
            locationManager.requestWhenInUseAuthorization()
            
        case CLAuthorizationStatus.restricted:
            
            print("Restricted Access to location ⚠️")
            
        case CLAuthorizationStatus.denied:
            
            print("User denied access to location ⁉️")
            self.nc.post(name: .locationOff, object: nil, userInfo: nil)
        case CLAuthorizationStatus.authorizedWhenInUse:
            
            if #available(iOS 9.0, *) {
                
                locationManager.requestLocation()
                
            } else {
                
                locationManager.startUpdatingLocation()
            }
            
        default:
            
            print("default authorization ⚠️")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueueHelper.delay(bySeconds: 0.1, dispatchLevel: .userInteractive) {
            let locValue = locations.last
            print("Location coordinate is \(locValue?.coordinate.latitude ?? 0),\(locValue?.coordinate.latitude ?? 0) 📡")
            
            let data = ["location":locValue]
            self.nc.post(name:.sendLocation,
                         object: nil,
                         userInfo: data as [AnyHashable : Any])
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        
    }
}
