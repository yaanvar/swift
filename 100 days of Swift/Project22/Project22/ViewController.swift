//
//  ViewController.swift
//  Project22
//
//  Created by Anvar Rahimov on 21.02.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager?
    var firstBeaconFound = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: view.center.x, y: view.center.y), radius: CGFloat(128), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScaning()
                }
            }
        }
    }
    
    func startScaning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "RIGHT HERE"
                if !self.firstBeaconFound {
                    let ac = UIAlertController(title: "First beacon was found!", message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
                self.view.layer.cornerRadius = 1
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
                self.view.layer.cornerRadius = 0.5
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
                self.view.layer.cornerRadius = 0.25
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
                self.view.layer.cornerRadius = 0.001
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }

}

