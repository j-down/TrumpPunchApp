//
//  TPLocationViewController.swift
//  TrumpPunch
//
//  Created by Ryan Coyne on 2/26/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import DTMHeatmap

class TPLocationViewController: UIViewController, MKMapViewDelegate, HeatmapDelegate {
    
    // Delegate set in storyboard
    @IBOutlet var heatMap : MKMapView!
    @IBOutlet var navigationBar : UINavigationBar!
    
    var updatedLocations = false
    
    var dtm = DTMHeatmap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the HeatMapDelegate: (This will update the other users locations:
        TPLocationDelegate.shared.delegate = self
        
    }
    
    @IBAction func popBackToMain(sender: UIBarButtonItem) {
        // Dismiss this view controller:
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        // Fetch the data now that we are listening for the callback:
        if !updatedLocations {
            // First lets zoom in to the user a little:
            let span = MKCoordinateSpan(latitudeDelta: 0.010, longitudeDelta: 0.010)
            let region = MKCoordinateRegionMake(userLocation.coordinate, span)
            self.heatMap.setRegion(region, animated: true)
            
            TPLocationDelegate.shared.getUserLocationData(withLocation: userLocation.location)
            // Set this boolean so we dont update mutiple times:
            updatedLocations = true
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // Take care of the map view overlays:
        return DTMHeatmapRenderer(overlay: overlay)
    }
    
    //MARK: HeatMapDelegate Function:
    func updateHeatmapData(data: [NSValue : Double]) {
        // Set the data to the DTMHeatmap:
        self.dtm.setData(data)
        // Now add the DTMHeatmap as the overlay:
        self.heatMap.add(self.dtm)
    }
}
