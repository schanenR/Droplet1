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

//    @EnvironmentObject var session: SessionStore
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject static var userMessage: Message = Message()
    @ObservedObject var dropletModel = GetDropletData()
    
    
    private let zoom: Float = 18.5
    var newDelegate: Delegate?
    

    var mapView: GMSMapView!
    
    init() {
        let camera = GMSCameraPosition.camera(withLatitude: locationManager.latitude, longitude: locationManager.longitude, zoom: zoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        dropletModel.fetchDropletData()
        dropletModel.fetchLotusData(email: "schanen.r@gmail.com")
        newDelegate = Delegate(view: self)
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        print("DEBUG: NEW UIVIEW?")
        mapView.delegate = newDelegate
        return mapView
    }
    
    func updateMarkers() {
        
        if locationManager.latitude == 0 && locationManager.longitude == 0 {
            return
        }

        mapView.clear()

        for data in dropletModel.droplets {

            let location = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
            let currentPosition = CLLocation(latitude: locationManager.latitude , longitude: locationManager.longitude)
            let markerLocation = CLLocation(latitude: data.latitude, longitude: data.longitude)

//            let hasClassMemberRecipitent = data.responds(to: #recipient())

            if currentPosition.distance(from: markerLocation) > 7 {

                let distFeet = currentPosition.distance(from: markerLocation) * 3.28084

                let marker = GMSMarker()
                marker.title = "\(round(distFeet)) feet away"
                marker.position = location
                marker.map = mapView


//            else if the droplet is close and has recipient
            } else if data.isPrivate == false {

                let userData = UserData(
                    note: data.note,
                    date: data.date,
                    isPrivate: data.isPrivate
                )

                let marker = GMSMarker()
                marker.position = location
                marker.userData = userData
                marker.icon = UIImage(named: "pngdropletsmall")
                marker.map = mapView
            } else {
                let userData = UserData(
                    note: data.note,
                    date: data.date,
                    isPrivate: data.isPrivate
                )
                let marker = GMSMarker()
                marker.position = location
                marker.userData = userData
                marker.icon = UIImage(named: "smalllotus")
                marker.map = mapView
            }
        }
        for data in dropletModel.allLotus {
            
            let location = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
            let currentPosition = CLLocation(latitude: locationManager.latitude , longitude: locationManager.longitude)
            let markerLocation = CLLocation(latitude: data.latitude, longitude: data.longitude)
            
            if currentPosition.distance(from: markerLocation) > 7 {
                
                let distFeet = currentPosition.distance(from: markerLocation) * 3.28084
                
                let marker = GMSMarker()
                marker.title = "\(round(distFeet)) feet away"
                marker.position = location
                marker.map = mapView
            
            } else {
                let userData = UserData(
                    note: data.note,
                    date: data.date,
                    isPrivate: data.isPrivate
                )
                let marker = GMSMarker()
                marker.position = location
                marker.userData = userData
                marker.icon = UIImage(named: "smalllotus")
                marker.map = mapView
            }
        }
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        updateMarkers()
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: locationManager.latitude, longitude: locationManager.longitude))
    }
    
    class Delegate: NSObject, GMSMapViewDelegate {

        let myView: GoogleMapsView

        init(view: GoogleMapsView) {
            myView = view
        }

        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

            if (marker.userData != nil) {
                userMessage.message = (marker.userData as! UserData).note
                userMessage.date = (marker.userData as! UserData).date
            }

            print("Did tap marker")

            if userMessage.message != nil {
                print("There is a message")
                userMessage.message = (marker.userData as! UserData).note
                userMessage.date = (marker.userData as! UserData).date
                userMessage.isPrivate = (marker.userData as! UserData).isPrivate
                ViewRouter.shared.currentPage = .page3
            } else  {
                print("You are too far from the droplet!")
                mapView.selectedMarker = marker
            }
            return true
        }
    }
}

struct GoogleMapsView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView()
    }
}

