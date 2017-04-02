//
//  TPLocationViewController.swift
//  TrumpPunch
//
//  Created by Ryan Coyne on 2/26/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import DTMHeatmap

class TPLocationViewController: UIViewController, MKMapViewDelegate, HeatmapDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // Delegate set in storyboard
    @IBOutlet var heatMap : MKMapView!
    @IBOutlet var navigationBar : UINavigationBar!
    
    @IBOutlet var leaderboardTableView : UITableView!
    
    var updatedLocations = false
    
    var topThreeUserData = NSArray()
    
    var dtm = DTMHeatmap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the HeatMapDelegate: (This will update the other users locations:
        TPLocationDelegate.shared.delegate = self
        self.modalTransitionStyle = .flipHorizontal
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getTopThreeLeaderboardObjects()
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

    //MARK:  UITableViewDataSource Functions:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3
    }
    
    //MARK:  UITableViewDelegate Functions:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "lbCellIdentifier") as? TopThreeLeaderboardCell {
            // Set the name, place & picture:
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
extension TPLocationViewController {
    func getTopThreeLeaderboardObjects() {
        dbRef.queryOrdered(byChild: "punches").queryLimited(toFirst: 3).observeSingleEvent(of: .value, with:  { (snapshot) in
            let data = snapshot.value as? NSDictionary
            print(data)
        })
    }
}
