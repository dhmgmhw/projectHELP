//
//  MapTestViewController.swift
//  HELP
//
//  Created by Moon on 2021/10/29.
//

import UIKit
import MapKit

class RouteViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblDestinationName: UILabel!
    @IBOutlet weak var lblDestinationDistance: UILabel!
    @IBOutlet weak var lblWalkTime: UILabel!
    @IBOutlet weak var lblBikeTime: UILabel!
    
    var startingPoint: CLLocation?
    var destination: MKAnnotation?

    var destinationName: String = ""
    var destinationDistance: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        lblDestinationName.text = destinationName
        if destinationDistance > 1000 {
            lblDestinationDistance.text = "\(String( Int( ceil(destinationDistance) / 1000 ) ) ) Km"
        } else {
            lblDestinationDistance.text = "\(String( Int( ceil(destinationDistance) ) ) )m"
        }
        guard let startingPoint = startingPoint else { return }
        guard let destination = destination else { return }
        let loc1 = CLLocationCoordinate2D.init(latitude: startingPoint.coordinate.latitude, longitude: startingPoint.coordinate.longitude)
        let loc2 = CLLocationCoordinate2D.init(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
        showRouteOnMap(pickupCoordinate: loc1, destinationCoordinate: loc2)
        annotationMaker()
    }
        
    func annotationMaker() {
        guard let destination = destination else { return }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
        annotation.title = "도착지 : \(destinationName)"
        self.mapView.addAnnotation(annotation)
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            //for getting just one route
            if let route = unwrappedResponse.routes.first {
                timeForDistance(route.distance)
                //show on map
                self.mapView.addOverlay(route.polyline)
                //set the map area to show the route
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
        }
    }
 
    func timeForDistance(_ distance: Double) {
        let walkTime = distance / 5000 * 60
        let bikeTime = distance / 16000 * 60
        lblWalkTime.text = "약 \(Int(walkTime)) 분"
        lblBikeTime.text = "약 \(Int(bikeTime)) 분"
    }
    
    // delegate function for displaying the route overlay and styling it
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.purple
        renderer.lineWidth = 5.0
        return renderer
    }
    
}
