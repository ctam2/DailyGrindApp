//
//  LoginViewController.swift
//  DailyGrind
//
//  Created by Christy Tam on 5/8/20.
//  Copyright © 2020 Christy Tam. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        error.alpha = 0
    }
    
    func showError(_ message:String) {
        error.text = message
        error.alpha = 1
    }
    
    /*@IBAction func loginTapped(_ sender: Any) {
        if email.text != nil && password.text != nil {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (result,error) in
                if errorCheck != nil{
                    self.showError("Error!!")
                }
                else {
                    let uid = result?.user.uid
                    let ref = Database.database().reference(withPath: "users").child(uid!)
                    ref.setValue(["email" : self.email.test!])
                    red.setValue(["password" : self.password.test!])
                }
               
               }
    }*/
    
    @IBAction func loginTapped(_ sender: Any) {
        let emailAddress = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passWord = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: emailAddress, password: passWord) {
            (result, errorCheck) in
            
            if errorCheck != nil {
                // Couldn't sign in
                self.error.text = errorCheck!.localizedDescription
                self.error.alpha = 1
            }
            else {
                
                let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "myTabBar") as! UITabBarController
                
                self.view.window?.rootViewController = myTabBar
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
}
