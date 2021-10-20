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
                    let alert = UIAlertController(title: "오류", message: "위치 서비스 기능 허용이 필요합니다", preferredStyle: .alert)
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
                let alert = UIAlertController(title: "오류", message: "지도를 사용하기 위해선 위치 서비스 기능 허용이 필요합니다", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    // find location with Coordinate
    func findAddr(lat: CLLocationDegrees, long: CLLocationDegrees){
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "EN-en")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                var city: String?
                var location: String?
                if let area: String = address.last?.locality {
                    city = area
                    print(city ?? "?")
                }
                if let name: String = address.last?.name {
                    location = name
                    print(location ?? "?")
                }
            }
        })
    }

    // search place and make annotation mark function
    private func searchPlaces(_ searchText: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        searchRequest.region = mapView.region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            for item in response.mapItems {
                if let name = item.name,
                    let location = item.placemark.location {
                    print("검색결과 -> \(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                    let latitude = location.coordinate.latitude
                    let longitude = location.coordinate.longitude
                    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta:0.1, longitudeDelta:0.1))
                    self.mapView.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    annotation.title = name
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
//    private func searchPlaces(_ searchText: String) {
//        let searchRequest = MKLocalSearch.Request()
//        searchRequest.naturalLanguageQuery = searchText
//        searchRequest.region = mapView.region
//
//        let search = MKLocalSearch(request: searchRequest)
//        search.start { response, error in
//            guard let response = response else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error").")
//                return
//            }
//
//            for item in response.mapItems {
//                if let name = item.name,
//                    let location = item.placemark.location {
//                    print("검색결과 -> \(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
//                }
//            }
//        }
//    }
    
    func setMyLocationInfo() {
        findAddr(lat: currentLocation.coordinate.latitude, long: currentLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        currentLocation = locationManager.location
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

