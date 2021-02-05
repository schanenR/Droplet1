//
//  GoogleMapsView.swift
//  Droplet1
//
//  Created by Ada on 2/4/21.
//

import SwiftUI
import UIKit
import GoogleMaps
import CoreLocation

struct GoogleMapsView: UIViewRepresentable {
    
    @ObservedObject var locationManager = LocationManager()
    
    @ObservedObject static var userMessage: Message = Message()
    @EnvironmentObject var viewRouter: ViewRouter

    private let zoom: Float = 15.5
    var dropletArray: [Droplet] = testData
    let newDelegate = Delegate()

    var mapView: GMSMapView!
    
    init() {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = newDelegate

    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        return mapView
    }
    
    func updateMarkers() {
        
        if locationManager.latitude == 0 && locationManager.longitude == 0 {
            return
        }

        mapView.clear()

        for data in dropletArray {
            
            let location = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)

            let currentPosition = CLLocation(latitude: locationManager.latitude , longitude: locationManager.longitude)
            
            let markerLocation = CLLocation(latitude: data.latitude, longitude: data.longitude)

            if currentPosition.distance(from: markerLocation) > 50 {
                
//                print("location: \(location)")
//                print("distance from marker: \(currentPosition.distance(from: markerLocation))")
                
                let marker = GMSMarker()
                marker.position = location
                marker.map = mapView
            
            } else {

//                print("location: \(location)")
//                print("distance from marker: \(currentPosition.distance(from: markerLocation))")
                
                let marker = GMSMarker()
                marker.position = location
                marker.userData = data.note
//                marker.icon = GMSMarker.markerImage(with: .green)
                marker.icon = UIImage(named: "pngdropletsmall")
                marker.map = mapView
            }
        }
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        updateMarkers()
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
    }
    
    class Delegate: NSObject, GMSMapViewDelegate {
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            
            userMessage.message = marker.userData as? String
            
            print("Did tap marker")
            return true
            
        }
    }
    
    
}

struct GoogleMapsView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView()
    }
}

