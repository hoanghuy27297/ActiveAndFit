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

    var selectedDay: String?
    var dayList = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var selectedStartTime: String?
    var startTimeList = ["6:00", "6:30", "7:00", "7:30", "8:00", "8:30", "9:00", "9:30", "10:00", "10:30",
                        "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                        "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30",
                        "21:00", "21:30", "22:00"]

    var selectedSession: Int?
    var sessionList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]

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
            dayTextField.text = selectedDay
        } else if pickerView == startTimePickerView {
            selectedStartTime = startTimeList[row]
            startTimeTextField.text = selectedStartTime
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
