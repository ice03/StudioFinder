//
//  ViewController.swift
//  StudioFinder
//
//  Created by Admin on 04.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var navView: GradientView!
    
    var timer: DispatchSourceTimer?
    
    var offset = 0
    var currentLifeSpans = [String: Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        searchTxtField.delegate = self
    }

}

extension HomeVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    // Zoom area with all annotations on the map
    func zoom() {
        if mapView.annotations.count == 0 {
            return
        }
        
        let mapEdgePadding = UIEdgeInsets(top: 75, left: 20, bottom: 20, right: 20)
        var zoomRect = MKMapRect.null
        
        mapView.annotations.forEach({
            let point = MKMapPoint($0.coordinate)
            let pointRect = MKMapRect(x: point.x, y: point.y, width: 0.1, height: 0.1)
            
            if zoomRect.isNull {
                zoomRect = pointRect
            } else {
                zoomRect = zoomRect.union(pointRect)
            }
        })
        
        mapView.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)
    }
}

extension HomeVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        offset = 0
        timer?.cancel()
        timer = nil
        currentLifeSpans.removeAll()
        performSearch()
        view.endEditing(true)
        return true
    }
    
}

extension HomeVC {
    
    func performSearch() {
        if searchTxtField.text != "" {
            if mapView.annotations.count > 0 {
                mapView.removeAnnotations(mapView.annotations)
            }
            
            // Get annotations, add them to the map, zoom area with all annotations and run timer
            DataService.instance.getAnnotations(forPlace: searchTxtField.text!, offset: offset) { annotations, lifeSpans, count, error in
                DispatchQueue.main.async {
                    if error == nil, let annotations = annotations {
                        self.mapView.addAnnotations(annotations)
                        self.zoom()
                        self.startTimer(lifeSpans: lifeSpans!, count: count!)
                    } else if let error = error {
                        self.showAlert(withTitle: "Error", message: error)
                    }
                }
            }
        }
    }
    
    // Every second the timer starts and checks the annotations with expired
    func startTimer(lifeSpans: [String: TimeInterval], count: Int) {
        
        // Adding lifetime starting from current
        lifeSpans.forEach({
            currentLifeSpans.updateValue(Date() + $0.value, forKey: $0.key)
        })
        
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue(label: "timer", attributes: .concurrent))
        timer!.schedule(deadline: .now(), repeating: .seconds(1))
        
        timer!.setEventHandler { [unowned self] in
            for lifeSpan in self.currentLifeSpans {
                if lifeSpan.value <= Date() {
                    DispatchQueue.main.async {
                        if let annotation = self.mapView.annotations.first(where: { $0.title == lifeSpan.key }) {
                            self.mapView.removeAnnotation(annotation)
                            self.currentLifeSpans.removeValue(forKey: lifeSpan.key)
                        }
                    }
                }
            }
            
            // When all annotations are removed from the map - stop the timer
            if self.currentLifeSpans.count == 0 {
                DispatchQueue.main.async {
                    self.timer?.cancel()
                    self.timer = nil
                    
                    // If you still have something to download - run the search method again
                    if count > self.offset {
                        self.offset += 100
                        self.performSearch()
                    }
                }
            }
        }
        
        timer?.resume()
    }
    
}

