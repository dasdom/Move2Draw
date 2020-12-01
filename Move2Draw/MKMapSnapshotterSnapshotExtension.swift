//  Created by Dom on 01.12.20.
//  Copyright © 2020 dasdom. All rights reserved.
//

import MapKit

extension MKMapSnapshotter.Snapshot {
  func imageByAddingPath(with locations: [CLLocation]) -> UIImage? {
    
    UIGraphicsBeginImageContextWithOptions(image.size, true, 0.0)
    
    image.draw(at: .zero)
    
    let bezierPath = UIBezierPath()
    guard let firstCoordinate = locations.first?.coordinate else {
      return nil
    }
    let firstPoint = point(for: firstCoordinate)
    bezierPath.move(to: firstPoint)
    
    for location in locations.dropFirst() {
      let nextPoint = point(for: location.coordinate)
      bezierPath.addLine(to: nextPoint)
    }
    
    UIColor.red.setStroke()
    bezierPath.lineWidth = 2
    bezierPath.lineCapStyle = .round
    bezierPath.lineJoinStyle = .round
    bezierPath.stroke()
    
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
      fatalError()
    }
    UIGraphicsEndImageContext()
    
    return image
  }
}
