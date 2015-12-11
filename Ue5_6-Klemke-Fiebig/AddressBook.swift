//
//  AddressBook.swift
//  Ue3-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke & Julian Fiebig on 12/11/15.
//  Copyright © 2015 Felix E.C. Klemke & Julian Fiebig. All rights reserved.
//

import Foundation

class AddressBook: NSObject, NSCoding {
    
    var addressCards = [AddressCard]()
    var count = 0
    var nbrOfSections = 0
  var differentSurnameInitialLetters = [Character : Int]()
  
    override init() {
        super.init()
    }
  
  func countInitialLettersOfSurnames(){
    for addressCard in addressCards{
      if let chrSurnameLetter = addressCard.surname.characters.first {
        if(!differentSurnameInitialLetters.keys.contains(chrSurnameLetter)){
          differentSurnameInitialLetters[chrSurnameLetter] = 1
        }else{
          differentSurnameInitialLetters[chrSurnameLetter]! += 1
        }
      }
    }
    print("The number of sections is \(differentSurnameInitialLetters.count)")
  }
  
    func addCard(card: AddressCard){
        addressCards.append(card)
        addressCards.sortInPlace{ $0.surname.compare($1.surname) == .OrderedAscending }
        count = addressCards.count //update count
        countInitialLettersOfSurnames()
        print("The Addressbok has a new entry and was succsessfully sorted.")
    }
    
    func removeCard(card: AddressCard){
        if let i = addressCards.indexOf(card){
            addressCards[i].friends.removeAll()
            addressCards.removeAtIndex(i)
            count = addressCards.count //update count
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
//            print("Saving succeeded")
        }
    }
    
    func loadFile(path: String){
        if let newAddressBook = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
            as? [AddressCard] {
            print("The loading process was successful")
            addressCards = newAddressBook
            count = addressCards.count //update count
        } else {
            print("The loading process was NOT successful!")
            self.addressCards = [AddressCard]()
            count = 0
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