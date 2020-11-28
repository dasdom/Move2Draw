//  Created by dasdom on 26.11.20.
//  
//

import UIKit
import MapKit
import Combine

class ViewController: UIViewController {

  @IBOutlet var mapView: MKMapView!
  @IBOutlet var clearButton: UIButton!
  @IBOutlet var startButton: UIButton!
  @IBOutlet var shareButton: UIButton!
  
  var locationProvider: LocationProvider?
  var locations: [CLLocation] = [] {
    didSet {
      mapView.removeOverlays(mapView.overlays)
      
      let coordinates = locations.map { $0.coordinate }
      let overlay = MKPolyline(coordinates: coordinates,
                               count: coordinates.count)
      
      mapView.addOverlay(overlay)
    }
  }
  var subscription: AnyCancellable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    
    locationProvider = LocationProvider()
    subscription = locationProvider?.$lastLocation.sink(receiveValue: { location in
      if let location = location {
        self.locations.append(location)
        
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: 600,
                                        longitudinalMeters: 600)
        self.mapView.setRegion(region, animated: true)
      }
    })
  }
  
  @IBAction func startUpdates(_ sender: UIButton) {
    locationProvider?.start()
  }
}

extension ViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView,
               rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    
    let renderer = MKGradientPolylineRenderer(overlay: overlay)
    renderer.setColors([.red, .green, .blue, .yellow, .red, .green],
                       locations: [0, 0.2, 0.4, 0.6, 0.8, 1])
    renderer.lineWidth = 5
    return renderer
  }
}

