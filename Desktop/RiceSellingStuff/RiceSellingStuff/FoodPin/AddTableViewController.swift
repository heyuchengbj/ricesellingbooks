//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 3/9/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var typeTextField:UITextField!
    @IBOutlet weak var locationTextField:UITextField!
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var price:UITextField!

    @IBOutlet weak var conditionField: UITextField!
    @IBOutlet weak var yesButton:UIButton!
    @IBOutlet weak var noButton:UIButton!
    
    var isVisited = true
    
    var book:Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

/*    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 5
    }
*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 5 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func save() {
        
        // Form validation
        var errorField = ""
        
        if price.text == "" {
            errorField = "price"
        } else if nameTextField.text == "" {
            errorField = "book name"
        } else if typeTextField.text == "" {
            errorField = "ISBN"
        } else if locationTextField.text == "" {
            errorField = "course"
        } else if conditionField.text == "" {
            errorField = "condition"
        }
        
        if errorField != "" {
            
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the " + errorField + ". All fields are mandatory.", preferredStyle: .Alert)
            let doneAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(doneAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }

        // If all fields are correctly filled in, extract the field value
        print("Name: " + nameTextField.text!)
        print("Course: " + typeTextField.text!)
        print("ISBN Number: " + locationTextField.text!)
        print("Price: " + price.text!)
        
//        restaurants.append(Restaurant(name: <#T##String#>, type: <#T##String#>, location: <#T##String#>, image: <#T##String#>, isVisited: <#T##Bool#>))
        // Execute the unwind segue and go back to the home screen
        performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    }
    
    @IBAction func updateIsVisited(sender: AnyObject) {
        // Yes button clicked
        let buttonClicked = sender as! UIButton
        if buttonClicked == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
            noButton.backgroundColor = UIColor.grayColor()
        } else if buttonClicked == noButton {
            isVisited = false
            yesButton.backgroundColor = UIColor.grayColor()
            noButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
}
