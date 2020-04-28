//
//  ChargesViewController.swift
//  ActiveAndFit
//
//  Created by Huy Hoang on 28/4/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

class ChargesViewController: UIViewController {

    @IBOutlet weak var facilityLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!

    var selectedFacility = ""

    var selectedDay = ""
    var selectedDayIndex = 0

    var selectedStartTimeInt = 0
    var selectedStartTime = ""

    var selectedEndTimeInt = 0
    var selectedEndTime = ""

    var selectedSession = 0

    var total = 0.0
    var discount = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        facilityLabel.text = selectedFacility
        dayLabel.text = selectedDay
        sessionLabel.text = String(selectedSession)
        durationLabel.text = selectedStartTime + " - " + selectedEndTime
        calcCharges()
    }

    func calcCharges() {
        if selectedFacility == "Pool" {
            // if selectedDayIndex in range 0,4 -> selected day is between Monday-Friday
            if selectedDayIndex >= 1 && selectedDayIndex <= 5 {
                total = calcFee(offPeakFee: 20, peakFee: 25, peakHour: 1800)
            } else {
                total = calcFee(offPeakFee: 20, peakFee: 25, peakHour: 1200)
            }
        } else if selectedFacility == "Tennis court" || selectedFacility ==  "Squash court" || selectedFacility ==  "Yoga room" {
            // if selectedDayIndex in range 0,4 -> selected day is between Monday-Friday
            if selectedDayIndex >= 1 && selectedDayIndex <= 5 {
                total = calcFee(offPeakFee: 30, peakFee: 35, peakHour: 1800)
            } else {
                total = calcFee(offPeakFee: 30, peakFee: 35, peakHour: 1200)
            }
        } else {
            // if selectedDayIndex in range 0,4 -> selected day is between Monday-Friday
            if selectedDayIndex >= 1 && selectedDayIndex <= 5 {
                total = calcFee(offPeakFee: 40, peakFee: 45, peakHour: 1800)
            } else {
                total = calcFee(offPeakFee: 40, peakFee: 45, peakHour: 1200)
            }
        }

        totalLabel.text = "$" + String(format:"%.2f", total)
        if total > 100 {
            discount = (total * 10) / 100
            total -= discount
            discountLabel.text = "discount 10%: $" + String(format:"%.2f", discount) + " = $" + String(format:"%.2f", total)
        } else {
            discountLabel.text = ""
        }
    }

    func calcFee(offPeakFee: Int, peakFee: Int, peakHour: Int) -> Double {
        // compare the start time and end time with range of peak hours
        if selectedEndTimeInt < peakHour {
            // selection is in off-peak hours -> end time must be before 18:00
            return Double(offPeakFee * selectedSession)
        } else if selectedStartTimeInt > peakHour {
            // selection is in peak hours -> start time must be after 18:00
            return Double(peakFee * selectedSession)
        } else {
            // selection is in between off-peak hours and peak hours -> start time must be before 18:00 and end time is after 18:00
            let firstHalf = peakHour - selectedStartTimeInt
            let secondHalf = selectedEndTimeInt - peakHour

            var fee = 0.0

            if firstHalf % 100 == 0 {
                // the number of sessions from start time to peak hour is integer
                fee += Double((firstHalf / 100) * offPeakFee)
            } else {
                // the fee includes half an hour of the normal fee
                print(round(Double(firstHalf / 100)) + 0.5)
                fee += (round(Double(firstHalf / 100)) + 0.5) * Double(offPeakFee)
                print("Fee " + String(fee))
            }

            if secondHalf % 100 == 0 {
                // the number of sessions from start time to peak hour is integer
                fee += Double((secondHalf / 100) * peakFee)
            } else {
                // the fee includes half an hour of the normal fee
                fee += (round(Double(secondHalf / 100)) + 0.5) * Double(peakFee)
            }

            return fee
        }
    }

    @IBAction func goBackHome(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToHome", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
