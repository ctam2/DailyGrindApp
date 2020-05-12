//
//  HomeViewController.swift
//  DailyGrind
//
//  Created by Christy Tam on 5/8/20.
//  Copyright © 2020 Christy Tam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FSCalendar

class HomeViewController: UIViewController, FSCalendarDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // In loadView or viewDidLoad
        //let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
       // calendar.dataSource = self
        //calendar.delegate = self
       // calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        //view.addSubview(calendar)
        //self.calendar = calendar
    }
    
    /*func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY at h:mm a"
        let string = formatter.string(from: date)
        print("\(string)")
        
    }*/

    @IBAction func logoutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}


