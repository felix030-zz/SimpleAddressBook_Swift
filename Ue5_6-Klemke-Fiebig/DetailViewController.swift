//
//  DetailViewController.swift
//  Ue5_6-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke & Julian Fiebig on 11/12/15.
//  Copyright © 2015 Felix Klemke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  
  @IBOutlet weak var nameTF: UITextField!
  @IBOutlet weak var surnameTF: UITextField!
  @IBOutlet weak var addressTF: UITextField!
  @IBOutlet weak var cityTF: UITextField!
  @IBOutlet weak var hobbiesTF: UITextField!
  @IBOutlet weak var friendsTF: UITextField!

  var objects = AddressBook()
  var indexPath = NSIndexPath()
  
  var detailItem: AnyObject? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("\(indexPath.section) \(indexPath.row)")
    print("\(objects.getCellFromSectionIndexPathRow(indexPath).name)")
    
    // Do any additional setup after loading the view, typically from a nib.
    
    nameTF.text = objects.getCellFromSectionIndexPathRow(indexPath).name
    surnameTF.text = objects.getCellFromSectionIndexPathRow(indexPath).surname
    addressTF.text = "\(objects.getCellFromSectionIndexPathRow(indexPath).street) \(String(objects.getCellFromSectionIndexPathRow(indexPath).houseNbr))"
    cityTF.text = "\(String(objects.getCellFromSectionIndexPathRow(indexPath).zipCode)) \(String(objects.getCellFromSectionIndexPathRow(indexPath).city))"

    hobbiesTF.text = getHobbiesForArray(objects.getCellFromSectionIndexPathRow(indexPath).hobbies)
    friendsTF.text = getStringForArrayAdrsc(objects.getCellFromSectionIndexPathRow(indexPath).friends)
    self.configureView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getHobbiesForArray(sArr: [String]) -> String {
    var tempString = ""
    for s in sArr {
      if(tempString == ""){
        tempString += "\(s)"
      }else{
        tempString += ", \(s)"
      }
    }
    return tempString
  }
  
  func getStringForArrayAdrsc(friends: [AddressCard]) -> String{
    var tempString = ""
    for f in friends {
      if(tempString == ""){
        tempString += "\(f.name) \(f.surname)"
      }else{
        tempString += ", \(f.name) \(f.surname)"
      }
    }
    return tempString
  }
  
  @IBAction func nameEdited(sender: AnyObject) {
    objects.updateCellAtIndexPath(indexPath, name: nameTF.text!)
  }
  
  
  
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    objects.updateCellAtIndexPath(indexPath, name: nameTF.text!)
//    print("\(nameTF.text) in der prepare for seque")
//    
////    if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
////      //mit diesem produkt kommt man überall an die daten des AppDelegate
////      delegate.addTestData()
////      objects = delegate.objects
////    }
//    
////    objects.insertAtSectionAtIndex(indexPath, adrsCard: adrsCard)
////    print("\(adrsCard.surname)")
//    
////    if segue.identifier == "showDetail" {
////      let controller = (segue.destinationViewController as! UINavigationController).topViewController as! MasterViewController
////      controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
////      controller.navigationItem.leftItemsSupplementBackButton = true
////    }
//  }
  
}

