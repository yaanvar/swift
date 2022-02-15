//
//  ViewController.swift
//  Project16
//
//  Created by Anvar Rahimov on 15.02.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    var capitals: [Capital] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(showMapTypes))
 
        capitals.append(Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.5072222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics"))
        capitals.append(Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago"))
        capitals.append(Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light"))
        capitals.append(Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it"))
        capitals.append(Capital(title: "Washington", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself"))
        
        mapView.addAnnotations(capitals)
    }
    
    @objc func showMapTypes() {
        let ac = UIAlertController(title: "Pick map type:", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { _ in
            self.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { _ in
            self.mapView.mapType = .standard
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { _ in
            self.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "Muted standart", style: .default, handler: { _ in
            self.mapView.mapType = .mutedStandard
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = .blue
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.tintColor = .black
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        guard let placeName = capital.title else { return }
        let placeInfo = capital.info
        
        let web = UIAlertAction(title: "Wikipedia", style: .default){ _ in
            self.showWebView(urlString: "https://en.wikipedia.org/wiki/" + placeName)
        }
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        ac.addAction(web)
        
        present(ac, animated: true)
    }
    
    func showWebView(urlString: String) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? WebViewController else { return }
            
        vc.capitalURL = URL(string: urlString)
            
        navigationController?.pushViewController(vc, animated: true)
    }

}

