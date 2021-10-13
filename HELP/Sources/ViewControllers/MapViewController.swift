//
//  MapViewController.swift
//  HELP
//
//  Created by Moon on 2021/10/08.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    
    override func viewDidLoad() {
        showMap()
    }

    private func showMap() {
        if CLLocationManager.locationServicesEnabled() {
            if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
                    let alert = UIAlertController(title: "오류", message: "위치 서비스 기능이 꺼져있음", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.startUpdatingLocation()
                    locationManager.startMonitoringSignificantLocationChanges()
                    mapView.showsUserLocation = true
                    mapView.setUserTrackingMode(.follow, animated: true)
                }
            } else {
                let alert = UIAlertController(title: "오류", message: "위치 서비스 제공 불가", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
    }

    // keyboard dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnPointTapped(_ sender: UIButton) {
    }
    
    
    // return to my location
    @IBAction func btnUpdateCurrentRegionTapped(_ sender: UIButton) {
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
    }
}

