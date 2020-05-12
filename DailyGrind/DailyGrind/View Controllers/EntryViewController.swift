//
//  EntryViewController.swift
//  DailyGrind
//
//  Created by Christy Tam on 5/8/20.
//  Copyright © 2020 Christy Tam. All rights reserved.
//
//import RealmSwift
import UIKit
import FirebaseDatabase


class EntryViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    var task = ""
    var datePick = ""
    
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        setUpElements()
        
    }
    
    
    func setUpElements() {
        errorLabel.alpha = 0
    }
    
    func validateFields() -> String? {
        
        // Check all fields are filled in
        if taskTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Missing: Please fill everything in."
        }
        
        return nil
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let datePick = dateFormatter.string(from: datePicker.date)
        print(datePick)
        
        let task = self.taskTextField.text!
        
        ref?.child("Tasks").child("New Task").setValue(task)
        ref?.child("Tasks").child("New Date").setValue(datePick)
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        let tasks = storyboard?.instantiateViewController(withIdentifier: "tasks") as! ListViewController
        
        view.window?.rootViewController = tasks
        view.window?.makeKeyAndVisible()
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
}
