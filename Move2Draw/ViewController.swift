//  Created by dasdom on 26.11.20.
//  
//

import UIKit
import MapKit

class ViewController: UIViewController {

  @IBOutlet var mapView: MKMapView!
  @IBOutlet var clearButton: UIButton!
  @IBOutlet var startButton: UIButton!
  @IBOutlet var shareButton: UIButton!
  
  var locationProvider: LocationProvider?
  var locations: [CLLocation] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationProvider = LocationProvider(updateHandler: { location in
      self.locations.append(location)
      self.mapView.setCenter(location.coordinate, animated: true)
    })
  }
  
  @IBAction func startUpdates(_ sender: UIButton) {
    locationProvider?.start()
  }
}

