//
//  ScheduleViewController.swift
//  ActiveAndFit
//
//  Created by Huy Hoang on 27/4/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    

    @IBOutlet weak var facilityName: UILabel!
    
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var sessionTextField: UITextField!
    
    let dayPickerView = UIPickerView()
    let startTimePickerView = UIPickerView()
    let sessionPickerView = UIPickerView()
    
    var selectedFacilityName = ""
    var selectedFacilityIndex = 0

    var selectedDay = ""
    var dayList = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var selectedDayIndex = 0

    var selectedStartTime = ""
    var selectedStartTimeInt = 0
    var startTimeList = ["6:00", "6:30", "7:00", "7:30", "8:00", "8:30", "9:00", "9:30", "10:00", "10:30",
                        "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                        "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30",
                        "21:00", "21:30", "22:00"]
    var startTimeIntList = [600, 630, 700, 730, 800, 830, 900, 930, 1000, 1030,
                            1100, 1130, 1200, 1230, 1300, 1330, 1400, 1430, 1500, 1530,
                            1600, 1630, 1700, 1730, 1800, 1830, 1900, 1930, 2000, 2030,
                            2100, 2130, 2200]
    var startTimeIndex = 0

    var selectedSession = 0
    var sessionList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        facilityName.text = selectedFacilityName
        createPickerView()
        dismissPickerView()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dayPickerView {
            return dayList.count
        } else if pickerView == startTimePickerView {
            return startTimeList.count
        } else {
            return sessionList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dayPickerView {
            return dayList[row]
        } else if pickerView == startTimePickerView {
            return startTimeList[row]
        } else {
            return String(sessionList[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dayPickerView {
            selectedDay = dayList[row]
            selectedDayIndex = row
            dayTextField.text = selectedDay
        } else if pickerView == startTimePickerView {
            selectedStartTime = startTimeList[row]
            selectedStartTimeInt = startTimeIntList[row]
            startTimeIndex = row
            startTimeTextField.text = selectedStartTime

            changeSessionList(row: row)
        } else {
            selectedSession = sessionList[row]
            sessionTextField.text = String(sessionList[row])
        }
    }
    
    func createPickerView() {
        dayPickerView.delegate = self
        startTimePickerView.delegate = self
        sessionPickerView.delegate = self

        dayTextField.inputView = dayPickerView
        startTimeTextField.inputView = startTimePickerView
        sessionTextField.inputView = sessionPickerView

        // get the initial day of week in number
        let calendar = Calendar.autoupdatingCurrent
        // get index of the current day and assign to variables
        selectedDayIndex = calendar.component(.weekday, from: Date()) - 1
        selectedDay = dayList[selectedDayIndex]
        dayPickerView.selectRow(selectedDayIndex, inComponent: 0, animated: false)
        dayTextField.text = selectedDay

        // get initial start time
        let hour = calendar.component(.hour, from: Date())
        let minute = calendar.component(.minute, from: Date())
        // get the index of current hour
        startTimeIndex = startTimeIntList.firstIndex(of: hour * 100)!
        if minute - 30 < 0 {
            // the current time is before half an hour e.g 16:15
            // then the initial start time is 16:30
            startTimeIndex += 1
        } else {
            // otherwise the start time is 17:00
            startTimeIndex += 2
        }
        selectedStartTime = startTimeList[startTimeIndex]
        selectedStartTimeInt = startTimeIntList[startTimeIndex]
        startTimePickerView.selectRow(startTimeIndex, inComponent: 0, animated: false)
        startTimeTextField.text = selectedStartTime
        changeSessionList(row: startTimeIndex)

        // assign initial value for the number of sessions as the first index in the list
        selectedSession = sessionList[0]
        sessionPickerView.selectRow(0, inComponent: 0, animated: false)
        sessionTextField.text = String(selectedSession)
    }

    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true

        dayTextField.inputAccessoryView = toolBar
        startTimeTextField.inputAccessoryView = toolBar
        sessionTextField.inputAccessoryView = toolBar
    }

    @objc func action() {
        view.endEditing(true)
    }

    func changeSessionList(row: Int) {
        // after chosing the start time, the range of session available must be changed
        var startTimeInt = selectedStartTimeInt
        if selectedStartTimeInt % 100 != 0 {
            // if the start time is not even e.g 16:30, the number of available session must be reduce 1
            startTimeInt = startTimeIntList[row + 1]
        }
        let maxRangeSession = (2200 - startTimeInt) / 100
        var tempSessionList = Array<Int>()
        for i in 1...maxRangeSession {
            tempSessionList.append(i)
        }
        sessionList = tempSessionList
    }

    @IBAction func submitButton(_ sender: Any) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowCharges" {
            let chargesViewController = segue.destination as! ChargesViewController

            chargesViewController.selectedFacility = selectedFacilityName

            chargesViewController.selectedDay = selectedDay
            chargesViewController.selectedDayIndex = selectedDayIndex

            chargesViewController.selectedSession = selectedSession
            chargesViewController.selectedStartTime = selectedStartTime
            chargesViewController.selectedStartTimeInt = selectedStartTimeInt
            chargesViewController.selectedEndTime = startTimeList[startTimeIndex + selectedSession * 2]
            chargesViewController.selectedEndTimeInt = startTimeIntList[startTimeIndex + selectedSession * 2]
        }
    }


}
