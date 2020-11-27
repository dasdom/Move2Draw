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
    
    locationProvider = LocationProvider()
  }
  
  @IBAction func startUpdates(_ sender: UIButton) {
    locationProvider?.start()
  }
}

