//
//  TPLocationViewController.swift
//  TrumpPunch
//
//  Created by Ryan Coyne on 2/26/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import DTMHeatmap
import Kingfisher

class TPLocationViewController: UIViewController, MKMapViewDelegate, HeatmapDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // Delegate set in storyboard
    @IBOutlet var heatMap : MKMapView!
    @IBOutlet var navigationBar : UINavigationBar!
    
    @IBOutlet var leaderboardTableView : UITableView!
    
    var updatedLocations = false
    
//    var topThreeUserData = [NSDictionary]()
    var topThreeUserData = Array<(String,AnyObject)>()
    
    var dtm = DTMHeatmap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the HeatMapDelegate: (This will update the other users locations:
        TPLocationDelegate.shared.delegate = self
        // Lets have some fun transitioning to this page:
        self.modalTransitionStyle = .flipHorizontal
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getTopThreeLeaderboardObjects {
            returnData in
            if let array = returnData {
                self.topThreeUserData = array
                self.leaderboardTableView.reloadData()
            }
        }
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
            self.updatedLocations = true
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
        return self.topThreeUserData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3
    }
    
    //MARK:  UITableViewDelegate Functions:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "lbCellIdentifier") as? TopThreeLeaderboardCell {
            // Set the name, place & picture:
            let tmp = self.topThreeUserData[indexPath.row] as (String,AnyObject)
            let dic = tmp.1
            let punches = dic["trumpPunches"] as? Int ?? 0
            cell.placeLabel.text = "\(indexPath.row + 1)"
            if let fullName = dic["fullName"] as? String {
                cell.nameLabel.text = fullName + ": \(punches)"
            } else if let username = dic["username"] as? String {
                cell.nameLabel.text = username + ": \(punches)"
            } else {
                cell.nameLabel.text = "Anonymous: \(punches)"
            }
            if let pictureURL = dic["pictureURL"] as? String {
                // Set the imageURL:
                if let picURL = URL(string: pictureURL) {
                    cell.imgView.kf.setImage(with: picURL)
                }
            } else {
                cell.imgView.image = UIImage(named: "AppLogo")!
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
extension TPLocationViewController {
    // This is the very top no matter your location for punching trump!
    func getTopThreeLeaderboardObjects(block: @escaping (_ arrayReturn : [(key: String, value: AnyObject)]?) -> Void) {
        dbRef.queryOrdered(byChild: "trumpPunches").queryLimited(toLast: 3).observe(.value, with: { (snap) in
            
//            let di = snap.value as? NSDictionary
            let di = snap.value as? [String:AnyObject]
            
            // Good ole' google doesn't order the query return for us.... So lets just do it!!! ->
            let filteredArray = di?.sorted(by: { (dic1, dic2) -> Bool in
                // We have to define our comparator here:
                let dicOne = dic1.value as! [String:AnyObject]
                let dicTwo = dic2.value as! [String:AnyObject]
                if let punch = dicOne["trumpPunches"] as? Int {
                    if let punch2 = dicTwo["trumpPunches"] as? Int {
                        return punch > punch2
                    } else {
                        return punch > 0
                    }
                } else {
                    if dicTwo["trumpPunches"] as? Int != nil {
                        return false
                    } else {
                        return false
                    }
                }
            })
            
            // Return the array in the block: This may or may not be nil:
            block(filteredArray)
            
        })
    }
}
