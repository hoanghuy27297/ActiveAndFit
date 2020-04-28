//
//  FacilitiesTableViewController.swift
//  ActiveAndFit
//
//  Created by Huy Hoang on 27/4/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

class FacilitiesTableViewController: UITableViewController {

    var facilitiesMenu = [String]()
    var facilitiesIcon = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        facilitiesMenu = ["Pool", "Tennis court", "Squash court", "Yoga room", "Functional fitness"]
        facilitiesIcon = ["pool", "tennis", "squash", "yoga", "fitness"]

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return facilitiesMenu.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FacilitiesCell", for: indexPath) as! FacilitiesTableViewCell

        let row = indexPath.row
        cell.facilityLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        cell.facilityLabel.text = facilitiesMenu[row]
        cell.facilityImage.image = UIImage(named: facilitiesIcon[row])

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSchedule" {
            let scheduleViewController = segue.destination as! ScheduleViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            scheduleViewController.selectedFacilityName = facilitiesMenu[row]
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */





}
