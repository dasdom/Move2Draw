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
  var locations: [CLLocation] = []
  var subscription: AnyCancellable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationProvider = LocationProvider()
    subscription = locationProvider?.$lastLocation.sink(receiveValue: { location in
      if let location = location {
        self.locations.append(location)
        self.mapView.setCenter(location.coordinate, animated: true)
      }
    })
  }
  
  @IBAction func startUpdates(_ sender: UIButton) {
    locationProvider?.start()
  }
}

