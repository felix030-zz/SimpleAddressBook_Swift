//
//  MasterViewController.swift
//  Ue5_6-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke on 11/12/15.
//  Copyright © 2015 Felix Klemke. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil
//  var objects = [AnyObject]()
//    var objects = [AddressCard]()
    var objects = AddressBook()
  
  //creating contatcs
  let testContact1 = AddressCard(name: "Felix", surname: "Klemke", street: "Kiautschoustr.", houseNbr: 19, zipCode: 13353, city: "Berlin", hobbies: ["Swift 2.1", "Swift 2.2"], friends: nil, imageName: UIImage(named: "FelixKlemke.png"))
  
  let testContact2 = AddressCard(name: "Julian", surname: "Fiebig", street: "Ostseestr.", houseNbr: 88, zipCode: 12333, city: "Berlin", hobbies: ["Fußball", "Union"], friends: nil, imageName: UIImage(named: "JulianFiebig.png"))
  
  let testContact3 = AddressCard(name: "Leon", surname: "Ehrenberg", street: "Kantstr.", houseNbr: 66, zipCode: 10303, city: "Berlin", hobbies: ["Tantra", "Prokrastination"], friends: nil, imageName: UIImage(named: "LeonEhrenberg.png"))
  
  let testContact4 = AddressCard(name: "Johnny", surname: "TheSnake", street: "Berliner Allee.", houseNbr: 129, zipCode: 13086, city: "Berlin", hobbies: ["Bird watching", "Collecting Tea Bag Covers"], friends: nil, imageName: UIImage(named: "JohnnyTheSnake.png"))

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //adding test data
//    objects.append(testContact1)
//    objects.append(testContact2)
//    objects.append(testContact3)
//    objects.append(testContact4)

    objects.addCard(testContact1)
    objects.addCard(testContact2)
    objects.addCard(testContact3)
    objects.addCard(testContact4)
    
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem()

    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
    self.navigationItem.rightBarButtonItem = addButton
    if let split = self.splitViewController {
        let controllers = split.viewControllers
        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
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

//  func insertNewObject(sender: AnyObject) {
//    objects.insert(NSDate(), atIndex: 0)
//    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//  }

  // MARK: - Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
//            let object = objects[indexPath.row] as! NSDate
            let object = objects
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = object
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return objects.differentSurnameInitialLetters.count
//    return 3
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
//    let object = objects[indexPath.row] as! AddressCard
    let object = objects.addressCards[indexPath.row]
    cell.textLabel!.text = "\(object.name) \(object.surname)"
    cell.detailTextLabel?.text = "\(object.street). \(object.houseNbr) \(object.zipCode) \(object.city)"
    
    if let imageView = cell.imageView, bugImage = object.image {
      imageView.image = bugImage
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

