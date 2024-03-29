
//
//  MapViewController.swift
//  HELP
//
//  Created by Moon on 2021/10/08.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate  {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Float Panel
    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
        
    var locationManager = CLLocationManager()

    // passing data
    var currentLocation: CLLocation!
    var selectedAnnotation: MKAnnotation?
    var destinationName: String = ""
    var destinationDistance: Double = 0
    
    override func viewDidLoad() {
        searchBar.delegate = self
        mapView.delegate = self
        showMap()
        floatingPanelSetter()
    }
    
    private func floatingPanelSetter() {
        floatingView.isHidden = true
        // make floating panel shadow
        floatingView.layer.shadowColor = UIColor.black.cgColor
        floatingView.layer.masksToBounds = false
        floatingView.layer.shadowOffset = CGSize(width: 4, height: 4)
        floatingView.layer.shadowRadius = 5
        floatingView.layer.shadowOpacity = 0.7
        
        // make floating panel top radius
        floatingView.layer.cornerRadius = 10
        floatingView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
    func searchPlaces(_ searchText: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        searchRequest.region = mapView.region
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            // 어노테이션 초기화 함수 call
            self.removeAllAnnotations()
            
            for item in response.mapItems {
                if let name = item.name,
                   let location = item.placemark.location {
                    let latitude = location.coordinate.latitude
                    let longitude = location.coordinate.longitude
                    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta:0.1, longitudeDelta:0.1))
                    self.mapView.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    annotation.title = name
                    let address = item.placemark.description.components(separatedBy: " @")[0]
                    annotation.subtitle = address
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    // 어노테이션 제거 함수
    func removeAllAnnotations() {
        let annotations = mapView.annotations.filter {
            $0 !== self.mapView.userLocation
        }
        mapView.removeAnnotations(annotations)
    }
        
    // 내 위치 정보 불러오기 함수
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
        if floatingView.isHidden == false {
            floatingView.isHidden = true
        }
    }
    
    @IBAction func btnPointTapped(_ sender: UIButton) {
        if sender.currentTitle == "경찰서" {
            searchPlaces("police station")
        } else {
            searchPlaces("hospital")
        }
    }
    
    @IBAction func btnEmbassyTapped(_ sender: UIButton) {
        removeAllAnnotations()
        guard let coordinate = UserDefaults.standard.string(forKey: "embassyAddress") else { return }
        let latitude = Double(coordinate.components(separatedBy: ", ")[0])!
        let longitude = Double(coordinate.components(separatedBy: ", ")[1])!
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta:0.1, longitudeDelta:0.1))
        self.mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let name = UserDefaults.standard.string(forKey: "embassyName")!
        annotation.title = name
        self.mapView.addAnnotation(annotation)
    }
    
    // Find route!
    @IBAction func btnSearchRouteTapped(_ sender: UIButton) {
        if let routeData = currentLocation {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "RouteViewController") as? RouteViewController else { return }
            vc.startingPoint = routeData
            vc.destination = selectedAnnotation
            vc.destinationDistance = self.destinationDistance
            vc.destinationName = self.destinationName
            self.present(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "오류", message: "경로를 탐색할 수 없습니다. GPS를 확인해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    // return to my location
    @IBAction func btnUpdateCurrentRegionTapped(_ sender: UIButton) {
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
    }
}
    
extension MapViewController: UISearchBarDelegate {
    // searchBar 검색버튼 눌렀을때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = self.searchBar.text
        guard let text = text else { return }
        self.searchPlaces(text)
        // searchBar keyboard dismiss
        self.searchBar.endEditing(true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        guard let chaining = annotation.subtitle else { return }
        guard let subtitle = chaining else { return }
        floatingView.isHidden = false
        let name = subtitle.components(separatedBy: ",")
        var foundLocation: CLLocation {
            .init(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        }
        selectedAnnotation = annotation
        lblPlaceName.text = name[0]
        destinationName = name[0]
        lblAddress.text = subtitle
        if let distance = currentLocation?.distance(from: foundLocation) {
            if distance > 1000 {
                lblDistance.text = "\(String( Int( ceil(distance) / 1000 ) ) ) Km"
                destinationDistance = ceil(distance)
            } else {
                lblDistance.text = "\(String( Int( ceil(distance) ) ) ) m"
                destinationDistance = ceil(distance)
            }
        } else {
            lblDistance.text = "현재 내 위치를 찾을 수 없습니다."
        }
    }
}
