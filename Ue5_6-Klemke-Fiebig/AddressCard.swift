//
//  AddressCard.swift
//  Ue3-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke & Julian Fiebig on 12/11/15.
//  Copyright © 2015 Felix E.C. Klemke & Julian Fiebig. All rights reserved.
//

import Foundation
import UIKit

class AddressCard: NSObject, NSCoding {
  
  var name: String = ""
  var surname: String = ""
  var street: String = ""
  var houseNbr: Int = 0
  var zipCode: Int = 0
  var city: String = ""
  var hobbies = [String]()
  var friends = [AddressCard]()
  var image: String? = ""
  
  var firstSurnameLetter: Character{
    get{
      let firstChar = surname[surname.capitalizedString.startIndex]
      return firstChar
    }
  }
  
  override init(){
    name = ""
    surname = ""
    street = ""
    houseNbr = 0
    zipCode = 0
    city = ""
    hobbies = [String]()
    friends = [AddressCard]()
    super.init()
  }
  
  init(name: String, surname: String, street: String, houseNbr: Int, zipCode: Int, city: String, hobbies: [String]?, friends: [AddressCard]?){
    self.name = name
    self.surname = surname
    self.street = street
    self.houseNbr = houseNbr
    self.zipCode = zipCode
    self.city = city
    
    if let aHobby = hobbies {
      self.hobbies = aHobby
    }
    
    if let aFriend = friends{
      self.friends = aFriend
    }
    super.init()
  }
  
  init(name: String, surname: String, street: String, houseNbr: Int, zipCode: Int, city: String, hobbies: [String]?, friends: [AddressCard]?, imageName: String?){
    self.name = name
    self.surname = surname
    self.street = street
    self.houseNbr = houseNbr
    self.zipCode = zipCode
    self.city = city
    
    if let aHobby = hobbies {
      self.hobbies = aHobby
    }
    
    if let aFriend = friends{
      self.friends = aFriend
    }
    
    if let image = imageName {
      self.image = image
    }
    
    super.init()
  }
  
  func addHobby(hobby: String){
    hobbies.append(hobby)
  }
  
  func removeHobby(hobby: String){
    if let i = hobbies.indexOf(hobby){
      hobbies.removeAtIndex(i)
    }
  }
  
  func addFriend(friend: AddressCard){
    friends.append(friend)
  }
  
  func removeFriend(friend: AddressCard){
    if let i = friends.indexOf(friend){
      friends.removeAtIndex(i)
    }
  }
  
  
  func encodeWithCoder(aCoder: NSCoder){
    aCoder.encodeObject(name, forKey: "name")
    aCoder.encodeObject(surname, forKey: "surname")
    aCoder.encodeObject(street, forKey: "street")
    aCoder.encodeObject(houseNbr, forKey: "houseNbr")
    aCoder.encodeObject(zipCode, forKey: "zipCode")
    aCoder.encodeObject(city, forKey: "city")
    aCoder.encodeObject(hobbies, forKey: "hobbies")
    aCoder.encodeObject(friends, forKey: "friends")
    aCoder.encodeObject(image, forKey: "image")
  }
  
  required init?(coder aDecoder: NSCoder){
    if let aName = aDecoder.decodeObjectForKey("name") as? String {
      self.name = aName
    }
    if let aSurname = aDecoder.decodeObjectForKey("surname") as? String {
      self.surname = aSurname
    }
    if let street = aDecoder.decodeObjectForKey("street") as? String {
      self.street = street
    }
    if let houseNbr = aDecoder.decodeObjectForKey("houseNbr") as? Int {
      self.houseNbr = houseNbr
    }
    if let zipCode = aDecoder.decodeObjectForKey("zipCode") as? Int {
      self.zipCode = zipCode
    }
    if let city = aDecoder.decodeObjectForKey("city") as? String {
      self.city = city
    }
    if let hobbies = aDecoder.decodeObjectForKey("hobbies") as? [String] {
      self.hobbies = hobbies
    }
    if let friends = aDecoder.decodeObjectForKey("friends") as? [AddressCard] {
      self.friends = friends
    }
    if let imageName = aDecoder.decodeObjectForKey("image") as? String {
      self.image = imageName
    }
  }
  
}