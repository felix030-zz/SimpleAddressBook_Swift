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
//    print("\(indexPath.section) \(indexPath.row)")
//    print("\(objects.getCellFromSectionIndexPathRow(indexPath).name)")
    
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
  
  func getStringForArrayAdrsc(friends: [AddressCard]) -> String {
    var tempString = ""
    
    for f in friends {
      if(tempString.isEmpty){
        tempString += "\(f.name) \(f.surname)"
      }else{
        tempString += ", \(f.name) \(f.surname)"
      }
    }
    return tempString
  }
  
  @IBAction func nameEdited(sender: AnyObject) {
    objects.updateCellAtIndexPath(indexPath, adrsCard: upadteAValue(nameTF.text!, describtion: "name"))
  }
  //TODO doesnt work for first letter
  @IBAction func surnameEdited(sender: AnyObject) {
    objects.updateCellAtIndexPath(indexPath, adrsCard: upadteAValue(surnameTF.text!, describtion: "surname"))
    objects.refreshData()
  }
  //TODO refactor
  @IBAction func streetEdited(sender: AnyObject) {
    let addressArr = addressTF.text!.componentsSeparatedByString(" ")
    objects.updateCellAtIndexPath(indexPath, adrsCard: upadteAValue(addressArr[0], describtion: "street"))
    objects.updateCellAtIndexPath(indexPath, adrsCard: upadteAValue(addressArr[1], describtion: "houseNbr"))
  }
  //TODO refactor
  @IBAction func cityEdited(sender: AnyObject) {
    let addressArr = cityTF.text!.componentsSeparatedByString(" ")
    objects.updateCellAtIndexPath(indexPath, adrsCard: upadteAValue(addressArr[0], describtion: "zipCode"))
    objects.updateCellAtIndexPath(indexPath, adrsCard: upadteAValue(addressArr[1], describtion: "city"))
  }
  @IBAction func hobbiesEdited(sender: AnyObject) {
    objects.updateCellAtIndexPath(indexPath, adrsCard: upadteAValue(hobbiesTF.text!, describtion: "hobbies"))
  }
  @IBAction func friendsEdited(sender: AnyObject) {
    objects.updateCellAtIndexPath(indexPath, adrsCard: upadteAValue(friendsTF.text!, describtion: "friends"))
  }
  
  
  
  func upadteAValue(elementString: String, describtion: String) -> AddressCard{
    let tempCard = objects.getCellFromSectionIndexPathRow(indexPath)
    switch describtion {
    case "name": tempCard.name = elementString
    case "surname":
      tempCard.surname = elementString
      objects.refreshData()
    case "street": tempCard.street = elementString
    case "houseNbr": tempCard.houseNbr = Int(elementString)!
    case "zipCode": tempCard.zipCode = Int(elementString)!
    case "city": tempCard.city = elementString
    case "hobbies":
      let hobbiesArr = elementString.componentsSeparatedByString(", ")
      tempCard.hobbies = hobbiesArr
    case "friends":
      let friendsArr = elementString.componentsSeparatedByString(", ")
      var tempFriends = [AddressCard]()
      for friend in friendsArr{
        if let newFriend = (objects.getAdrsCardForFullName(friend)){
          tempFriends.append(newFriend)
        }
      }
      tempCard.friends = tempFriends
    
    default :
      print("default in switch case was triggered")
    }
    
    return tempCard
  }

  
}

