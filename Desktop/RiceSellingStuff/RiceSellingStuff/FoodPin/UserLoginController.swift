//
//  ViewController.swift
//  RiceSellingStuff
//
//  Created by apple on 1/16/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class UserLoginController: UIViewController, UINavigationControllerDelegate {
    
    var user: String = ""
    var password: String = ""
    
    
    
    

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBAction func logInButton(sender: UIButton) {
        
        var errorField = ""
        
        if userName.text == "" {
            errorField = "user name"
        } else if userPassword.text == "" {
            errorField = "password"
        }
        
        if errorField != "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the " + errorField + ". All fields are mandatory.", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        user = userName.text!
        password = userPassword.text!
        
        performSegueWithIdentifier("unwindToVC", sender: self)

        
    }
    

    //performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    func viewWillLoad(){
        if user != "" {
            
            performSegueWithIdentifier("unwindToVC", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToSignInScreen(segue:UIStoryboardSegue) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
