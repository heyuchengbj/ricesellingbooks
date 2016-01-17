//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 11/8/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    
    var user: String? = ""
    var password: String? = ""
    var books:[Book] = [
        Book(name: "Differential Equations And Linear Algebra", course: "MATH 211", ISBNNumber: "9780130457943", image: "211.jpg", condition: "Likely New", price: 40, seller: "Bob Zhang"),
        Book(name: "Discrete Mathematics and Its Applications", course: "COMP 182", ISBNNumber: "9780073383095", image: "182.jpg",  condition: "New", price: 50, seller: "Richard He"),
        Book(name: "Music in Theory and Practice", course: "MUSI 117", ISBNNumber: "9780077493318", image: "117.jpg", condition: "Moderate", price: 30, seller: "Yisong Qin"),
        Book(name: "Splendid Monarchy", course: "ASIA 219", ISBNNumber: "9780073383092", image: "219",  condition: "New", price: 18, seller: "Jesse Pan"),
        Book(name: "Principle of Economics", course: "ECON 100", ISBNNumber: "9780073383091", image: "100",  condition: "New", price: 31, seller: "Mike Dai"),

    ]
    var searchController:UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // Self Sizing Cells
        self.tableView.estimatedRowHeight = 80.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController.hidesBarsOnSwipe = true
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.books.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        
        // Configure the cell...
        let restaurant = books[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(named: restaurant.image)
        cell.locationLabel.text = restaurant.ISBNNumber
        cell.typeLabel.text = restaurant.course
        cell.price.text = "$" + String(restaurant.price)
        

        // Circular image
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
            let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.Default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default, handler: nil)
            let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
            }
        )
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: {
            (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            // Delete the row from the data source
            self.books.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)

            }
        )

        deleteAction.backgroundColor = UIColor(red: 237.0/255.0, green: 75.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        shareAction.backgroundColor = UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1.0)

        return [deleteAction, shareAction]
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showRestaurantDetail" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.book = books[row]
            }
        }
        
//        if segue.identifier == "toTheAccount" {
//
 //           var destinationController = segue.destinationViewController as! UserLoginController
//            destinationController.user = self.user!
 //           destinationController.password = self.password!
        

            
    
    }


    
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {

    }
    
    @IBAction func unwindToVC(segue:UIStoryboardSegue) {
        if(segue.sourceViewController .isKindOfClass(BooksTableViewController))
        {
            let view2:UserLoginController = segue.sourceViewController as! UserLoginController
            user = view2.user
            password = view2.password
        }
    }


    @IBAction func logIn(sender: UIBarButtonItem) {
    }
    
    
}
