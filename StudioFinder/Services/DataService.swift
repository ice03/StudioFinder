//
//  DataService.swift
//  StudioFinder
//
//  Created by Admin on 04.12.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import MapKit

class DataService {
    static let instance = DataService()
    
    // Method return annotations, lifespan each annotation and total count of results for a query, or error
    func getAnnotations(forPlace place: String, offset: Int, handler: @escaping (_ annotations: [MKPointAnnotation]?, _ lifeSpans: [String: TimeInterval]?, _ count: Int?, _ errorString: String?) -> ()) {
        
        let undscrPlace = place.replacingOccurrences(of: " ", with: "_")
        
        let urlString = "https://musicbrainz.org/ws/2/place/?query=\(undscrPlace)&offset=\(offset)&limit=100&fmt=json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                guard let data = data else { return }
                
                do {
                    let placeData = try JSONDecoder().decode(PlaceData.self, from: data)
                    
                    self.prepareData(placeData: placeData, handler: { annoations, lifeSpans in
                        handler(annoations, lifeSpans, placeData.count, nil)
                    })
                } catch let error {
                    handler(nil, nil, nil, error.localizedDescription)
                }
            } else {
                handler(nil, nil, nil, error?.localizedDescription)
            }
            }.resume()
    }
    
    // Helper method
    func prepareData(placeData: PlaceData, handler: @escaping (_ annotations: [MKPointAnnotation], _ lifeSpans: [String: TimeInterval]) -> ()) {
        var lifeSpans = [String: TimeInterval]()
        var annotations = [MKPointAnnotation]()
        
        // Filter results only from those who have coordinates and late 1990
        let places = placeData.places.filter({ (place) -> Bool in
            if let begin = place.lifeSpan.begin, place.coordinates != nil {
                
                let endIndex = begin.index(begin.startIndex, offsetBy: 3)
                let dateInt = Int(String(begin[begin.startIndex...endIndex]))
                
                if let date = dateInt, date >= 1990 {
                    let seconds = TimeInterval(date - 1990)
                    
                    lifeSpans.updateValue(seconds, forKey: place.name)
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        })
        
        // Creating annotation for each filtered result
        places.forEach({
            let annotation = MKPointAnnotation()
            
            let coordinates = CLLocationCoordinate2D(latitude: Double(($0.coordinates?.latitude)!)!, longitude: Double(($0.coordinates?.longitude)!)!)
            
            annotation.coordinate = coordinates
            annotation.title = $0.name
            annotation.subtitle = $0.address
            annotations.append(annotation)
        })
        
        handler(annotations, lifeSpans)
    }
    
}
