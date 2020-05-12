//
//  SignupViewController.swift
//  DailyGrind
//
//  Created by Christy Tam on 5/8/20.
//  Copyright © 2020 Christy Tam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


class SignupViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    // hide error label
    func setUpElements() {
        error.alpha = 0
    }
    
    // Checks fields and valdate data if correct
    func validateFields() -> String? {
        
        // Check all fields are filled in
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Missing: Please fill everything in."
        }
        
        // Check if password is secured
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Check to see if your password has a minimum of 8 charactes with number and special characters."
        }
        
        return nil
    }

    @IBAction func signupTapped(_ sender: Any) {
        
        //Validate the fields
        let errorCheck = validateFields()
        
        if errorCheck != nil {
            
            showError(errorCheck!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstname = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailAddress = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passWord = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create the user
            Auth.auth().createUser(withEmail: emailAddress, password: passWord) {
                (result, errorCheck) in
                
                // Check errors
                if errorCheck != nil {
                    
                    self.showError("Error: creating the user")
                }
                else {
    
                    let db = Firestore.firestore()
                                       
                    db.collection("users").addDocument(data: ["firstname":firstname, "lastname":lastname, "uid": result!.user.uid ]) { (errorCheck) in
                                           
                    if errorCheck != nil {
                        // Show error message
                        self.showError("Error saving the user data")
                        }
                        
                    }
                    //transition to the ome screen
                    self.transitionToHome()
                }
                
            }
        }
    }
    
   func showError(_ message:String) {
        error.text = message
        error.alpha = 1
    }
    
    func transitionToHome() {
        let myTabBar = storyboard?.instantiateViewController(withIdentifier: "myTabBar") as! UITabBarController
        //(identifier: Constants.Storyboard.tabBarController) as? UITabBarController
        
        view.window?.rootViewController = myTabBar
        view.window?.makeKeyAndVisible()
    }
    
}
