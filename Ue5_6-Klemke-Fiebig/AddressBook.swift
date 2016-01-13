//
//  AddressBook.swift
//  Ue3-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke & Julian Fiebig on 12/11/15.
//  Copyright © 2015 Felix E.C. Klemke & Julian Fiebig. All rights reserved.
//

import Foundation

enum Error: ErrorType {
  case NotFound
}

class AddressBook: NSObject, NSCoding {
  
  var addressCards = [AddressCard]()
  var sections = [Character]()
  
  override init() {
    super.init()
  }
  
  func refreshData(){
    //refresh sections
    for addressCard in addressCards {
      if(!sections.contains(addressCard.firstSurnameLetter)){
        sections.append(addressCard.firstSurnameLetter)
        sections.sortInPlace()
      }
    }
    //TODO Refresh addressCards
    
  }
  
  func updateCellAtIndexPath(idxPath: NSIndexPath, name: String){
    let letter = sections[idxPath.section]

    print("the letter we are looking for: \(letter)")
    print("index section is: \(idxPath.section) row is: \(idxPath.row)")
    
    var counter = 0
    for (index, element) in addressCards.enumerate() {
      print("counter value within enumeration \(counter)")
      
      if(element.firstSurnameLetter == letter){
        if(counter < idxPath.row){

          counter++
          print("counter incremented \(counter)")
        }else if(counter == idxPath.row){
          print("counter is == row")
          element.name = name
          break
        }
      }
    }
  }
  
  func getNbrOfSections() -> Int{
    for addressCard in addressCards {
      if(!sections.contains(addressCard.firstSurnameLetter)){
        sections.append(addressCard.firstSurnameLetter)
        sections.sortInPlace()
      }
    }
    return sections.count
  }
  
  func getNbrOfRowForSection(section: Int) -> Int{
    let letter = sections[section]
    var count = 0
    for addressCard in addressCards {
      if(addressCard.firstSurnameLetter == letter){
        count++
      }
    }
    return count
  }
  
  func getCellFromSectionIndexPath(section: Int) -> [AddressCard]{
    var sectionAdrsCards = [AddressCard]()
    let letter = sections[section]
    for addressCard in addressCards {
      if(addressCard.firstSurnameLetter == letter){
        sectionAdrsCards.append(addressCard)
      }
    }
    return sectionAdrsCards
  }
  
  func getCellFromSectionIndexPathRow(idxPath: NSIndexPath) -> AddressCard{
    var sectionAdrsCards = [AddressCard]()
    let letter = sections[idxPath.section]
    for addressCard in addressCards {
      if(addressCard.firstSurnameLetter == letter){
        sectionAdrsCards.append(addressCard)
      }
    }
    return sectionAdrsCards[idxPath.row]
  }
  
  func insertAtSectionAtIndex(idxPath: NSIndexPath, adrsCard: AddressCard){
//    if(sections[idxPath.section] == adrsCard.firstSurnameLetter){
//    }
      addressCards[idxPath.row] = adrsCard
  }
  
  func addCard(card: AddressCard){
    addressCards.append(card)
    addressCards.sortInPlace{ $0.surname.compare($1.surname) == .OrderedAscending
    }
    print("The Addressbok has a new entry and was succsessfully sorted.")
  }
  
  func removeCard(card: AddressCard){
    if let i = addressCards.indexOf(card){
      addressCards[i].friends.removeAll()
      addressCards[i].hobbies.removeAll()
      addressCards.removeAtIndex(i)
    }
  }
  
  func getName(surname: String) -> AddressCard? {
    for addressCard in addressCards {
      if addressCard.surname == surname {
        return addressCard
      }
    }
    return nil
  }
  
  func encodeWithCoder(aCoder: NSCoder){
    aCoder.encodeObject(addressCards, forKey: "anAddressBook")
  }
  
  func removeAllEntries(path: String){
    addressCards.removeAll()
    if NSKeyedArchiver.archiveRootObject(addressCards, toFile: path){
      //            print("Saving succeeded / All entries deleted")
    }
  }
  
  func saveToFile(path: String){
    if NSKeyedArchiver.archiveRootObject(addressCards, toFile: path){
      print("Saving succeeded")
    }
  }
  
  func loadFile(path: String){
    if let newAddressBook = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [AddressCard] {
      print("The loading process was successful")
      addressCards = newAddressBook
    } else {
      print("The loading process was NOT successful!")
      self.addressCards = [AddressCard]()
    }
  }
  
  func printEntireAdrsBookData(){
    print("Your Adressbook contains \(addressCards.count) contacts")
    for adrscard in addressCards{
      print("\nName: \(adrscard.name) \(adrscard.surname) \nAddress: \(adrscard.street) \(adrscard.zipCode) \(adrscard.city) \nHobbies: \(adrscard.hobbies) Friends: \(adrscard.friends)\n")
    }
  }
  
  func getAdrsCardForSurname(surname: String){
    if let adrscard = getName(surname){
      print("\nName: \(adrscard.name) \(adrscard.surname) \nAddress: \(adrscard.street) \(adrscard.zipCode) \(adrscard.city) \nHobbies: \(adrscard.hobbies) Friends: \(adrscard.friends)\n")
    }
  }
  
  required init?(coder aDecoder: NSCoder){
    if let getAddressCards = aDecoder.decodeObjectForKey("anAddressBook") as? [AddressCard] {
      addressCards = getAddressCards
    }
  }
  
}