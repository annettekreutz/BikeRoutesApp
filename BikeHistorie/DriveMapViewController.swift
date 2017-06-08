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
    
//    var location = String("Hanau")
//    var latitude = Double(50.1264123)
//    var longitude = Double(8.9283105)
  
    var mapLocation = MapLocation(location: "Hanau",latitude: Double(50.1264123),longitude: Double(8.9283105))

    @IBAction func showSearchBar(_ sender: Any) {
     
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate =  self
        present(searchController, animated: true, completion: nil)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        //1
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
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
            self.pointAnnotation.title = searchBar.text
            
            let  latitude = Double(localSearchResponse!.boundingRegion.center.latitude)
            let longitude = Double(localSearchResponse!.boundingRegion.center.longitude)
            
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude
                , longitude: longitude)
            
            self.mapLocation = MapLocation(location: searchBar.text!, latitude: latitude, longitude: longitude)
            self.testLabel.text = self.mapLocation.location
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
        }
    }
     func updateAttributes(mapLocation :MapLocation) {
        self.mapLocation = mapLocation;
        
     }
    override func viewDidLoad() {
        super.viewDidLoad()
       // Hanau
        testLabel.text = mapLocation.location
        let initialLocation = CLLocation(latitude: mapLocation.latitude, longitude: mapLocation.longitude)
 
        centerMapOnLocation(location: initialLocation)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
 

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
