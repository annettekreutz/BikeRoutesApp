//
//  DriveMapViewController.swift
//  BikeHistorie
//
//  Created by Team_iOS on 07.06.17.
//  Copyright © 2017 Team_iOS. All rights reserved.
//
import UIKit
import MapKit

class DriveMapViewController: UIViewController, UISearchBarDelegate  {

    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    // see http://sweettutos.com/2015/04/24/swift-mapkit-tutorial-series-how-to-search-a-place-address-or-poi-in-the-map/
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    let regionRadius: CLLocationDistance = 1000
    var mapLocation = MapLocation(location: "Hanau",latitude: Double(50.1264123),longitude: Double(8.9283105))
    
    @IBOutlet weak var tempLabel: UILabel!
    var temp = String()
    
    var weather = WeatherGetter()
    
    // view starting
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Location of Tour"
        let location = mapLocation.location
        self.testLabel.text = location
        weather.getWeather(city: location, callback: { weather in
            DispatchQueue.main.async {
                self.tempLabel.text = weather   
            }
        })
        
        let latitude = mapLocation.latitude
        let longitude = mapLocation.longitude
        if(latitude > 0 && longitude > 0 ) {
            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            centerMapOnLocation(location: initialLocation)
            return
        }
        searchWithText(searchText:  mapLocation.location)
       
    }
    
//    // search bar
//    @IBAction func showSearchBar(_ sender: Any) {
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.hidesNavigationBarDuringPresentation = false
//        self.searchController.searchBar.delegate =  self
//        present(searchController, animated: true, completion: nil)
//    }
    // action search
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
//        //1
//        searchBar.resignFirstResponder()
//        dismiss(animated: true, completion: nil)
//        if self.mapView.annotations.count != 0{
//            annotation = self.mapView.annotations[0]
//            self.mapView.removeAnnotation(annotation)
//        }
//        searchWithText(searchText: searchBar.text!)
//    }
    // search location text without coord
    func searchWithText(searchText: String ){
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchText
        localSearch = MKLocalSearch(request: localSearchRequest)
       
        localSearch.start { (localSearchResponse, error) -> Void in
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchText
            
            let  latitude = Double(localSearchResponse!.boundingRegion.center.latitude)
            let longitude = Double(localSearchResponse!.boundingRegion.center.longitude)
            let regionRadius: CLLocationDistance = 1000
            
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude
                , longitude: longitude)
           // let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            
            self.mapLocation = MapLocation(location: searchText,  latitude: latitude, longitude: longitude , temp: self.temp)
            self.testLabel.text = self.mapLocation.location
            self.tempLabel.text = self.mapLocation.temp
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(self.pointAnnotation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
            self.mapView.setRegion(coordinateRegion, animated: true)

        }
    }
    // update location by seque
    func updateAttributes(mapLocation :MapLocation) {
        self.mapLocation = mapLocation;
        self.temp = mapLocation.temp
     
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // set location with coord and radius
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
