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
  var adrsCard = AddressCard()
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
    // Do any additional setup after loading the view, typically from a nib.
    nameTF.text = adrsCard.name
    surnameTF.text = adrsCard.surname
    addressTF.text = "\(adrsCard.street) \(String(adrsCard.houseNbr))"
    cityTF.text = "\(String(adrsCard.zipCode)) \(String(adrsCard.city))"
    hobbiesTF.text = getHobbiesForArray(adrsCard.hobbies)
    friendsTF.text = getStringForArrayAdrsc(adrsCard.friends)
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      let controller = (segue.destinationViewController as! UINavigationController).topViewController as! MasterViewController
      controller.adrsCardFromDetail = adrsCard
      controller.indexPathFromDetail = indexPath
      controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
      controller.navigationItem.leftItemsSupplementBackButton = true
    }
  }
  
}

