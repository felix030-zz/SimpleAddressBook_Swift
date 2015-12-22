//
//  MasterViewController.swift
//  Ue5_6-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke & Julian Fiebig on 11/12/15.
//  Copyright © 2015 Felix Klemke. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = AddressBook()
    
    //TODO has to be done differentyl
    //  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //    let aLetterSection = letterSections.addressCards[section]
    //    return aLetterSection.letter
    //  }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding test data
        //    addTestData()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        editButtonItem().tintColor = UIColor.blackColor()
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        addButton.tintColor = UIColor.blackColor()
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        //TODO put back
        if let del = UIApplication.sharedApplication().delegate as? AppDelegate{
            //mit diesem produkt kommt man überall an die daten des AppDelegate
            del.addTestData()
            //      del.load()
            objects = del.objects
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func insertNewObject(sender: AnyObject) {
    //      objects.insert(NSDate(), atIndex: 0)
    //      let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    //      self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    //    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    //  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //    return objects.addressCards.count
    //  }
    
    //  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    ////    return objects.differentSurnameInitialLetters.count
    //    return 5
    //  }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.addressCards.count
    }
    
    //  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    let section = letterSections.addressCards[section]
    //    return section.addressCards.count
    //  }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        //    let object = objects[indexPath.row] as! AddressCard
        let object = objects.addressCards[indexPath.row]
        cell.textLabel!.text = "\(object.name) \(object.surname)"
        cell.detailTextLabel?.text = "\(object.street). \(object.houseNbr) \(object.zipCode) \(object.city)"
        
        if let imageView = cell.imageView, image = object.image {
            imageView.image = UIImage(named: image)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.addressCards.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}

