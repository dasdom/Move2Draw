//  Created by dasdom on 26.11.20.
//  
//

import UIKit
import CoreLocation

class LocationProvider: NSObject {

  let locationManager: CLLocationManager
  let updateHandler: (CLLocation) -> Void
  
  init(updateHandler: @escaping (CLLocation) -> Void) {
    
    self.updateHandler = updateHandler
    locationManager = CLLocationManager()
    
    super.init()
    
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
  }
}

extension LocationProvider: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
      case .authorizedWhenInUse:
        print("authorizedWhenInUse")
      case .denied:
        print("denied")
      case .notDetermined:
        print("notDetermined")
      case .restricted:
        print("restricted")
      default:
        print("else: \(manager.authorizationStatus)")
    }
    
    switch manager.accuracyAuthorization {
      case .fullAccuracy:
        print("fullAccuracy")
      case .reducedAccuracy:
        print("reducedAccuracy")
      @unknown default:
        fatalError()
    }
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    print("locations: \(locations)")
    if let lastLocation = locations.last {
      updateHandler(lastLocation)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error: \(error)")
  }
  
  func start() {
    if locationManager.accuracyAuthorization == .reducedAccuracy {
      locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "DrawOnMap") { error in
        if self.locationManager.accuracyAuthorization == .fullAccuracy {
          self.locationManager.startUpdatingLocation()
        }
      }
    } else {
      locationManager.startUpdatingLocation()
    }
  }
}
