//
//  AppDelegate.swift
//  Ue5_6-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke & Julian Fiebig on 11/12/15.
//  Copyright © 2015 Felix Klemke. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
  
  var window: UIWindow?
  var objects = AddressBook()
  var filename: String = ""
  let urls = NSFileManager.defaultManager().URLsForDirectory(  .DocumentDirectory, inDomains: .UserDomainMask)
  
  func saveMe(){
    let url = urls[urls.count-1] as NSURL
    if let path = url.path {
      filename = (path as NSString).stringByAppendingPathComponent("book.archive")
      objects.saveToFile(filename)
    }
  }
  
  func loadMe(){
    let url = urls[urls.count-1] as NSURL
    if let path = url.path {
      filename = (path as NSString).stringByAppendingPathComponent("book.archive")
      objects.loadFile(filename)
    }
  }
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    NSThread.sleepForTimeInterval(2.5)
    
    let splitViewController = self.window!.rootViewController as! UISplitViewController
    let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
    navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
    splitViewController.delegate = self
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func addTestData(){
//creating contatcs
//    let testContact1 = AddressCard(name: "Felix", surname: "Klemke", street: "Kiautschoustr.", houseNbr: 19, zipCode: 13353, city: "Berlin", hobbies: ["Swift 2.1", "Swift 2.2"], friends: nil, imageName: "mustache.png")
//    let testContact2 = AddressCard(name: "Julian", surname: "Fiebig", street: "Ostseestr.", houseNbr: 88, zipCode: 12333, city: "Berlin", hobbies: ["Fußball", "Union"], friends: nil, imageName: "mustache.png")
//    let testContact3 = AddressCard(name: "Leon", surname: "Ehrenberg", street: "Kantstr.", houseNbr: 66, zipCode: 10303, city: "Berlin", hobbies: ["Tantra", "Prokrastination"], friends: nil, imageName: "mustache.png")
//    let testContact4 = AddressCard(name: "Johnny", surname: "TheSnake", street: "Berliner Allee.", houseNbr: 129, zipCode: 13086, city: "Berlin", hobbies: ["Bird watching", "Collecting Tea Bag Covers"], friends: nil, imageName: "mustache.png")
//    let testContact5 = AddressCard(name: "Gregor", surname: "Klamke", street: "Tassostr.", houseNbr: 21, zipCode: 13386, city: "Berlin", hobbies: ["Company of Heros", "Carving Egg Shells"], friends: [testContact4, testContact1], imageName: "mustache.png")
//    addContact(testContact1)
//    addContact(testContact2)
//    addContact(testContact3)
//    addContact(testContact4)
//    addContact(testContact5)
//    saveMe()
  loadMe()
  }
  
  func addContact(addrsCard: AddressCard){
    //may the lord forgive me for this, and give me strength to refactor!
    objects.addCard(addrsCard)
    print("addrsCard added")
  }

  // MARK: - Split view
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
    guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
    guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
    if topAsDetailController.detailItem == nil {
      // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
      return true
    }
    return false
  }
  
}

