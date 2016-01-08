//
//  DetailViewController.swift
//  Ue5_6-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke & Julian Fiebig on 11/12/15.
//  Copyright © 2015 Felix Klemke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameLBL: UILabel!
  @IBOutlet weak var surnameLBL: UILabel!
  @IBOutlet weak var streetLBL: UILabel!
  @IBOutlet weak var houseLBL: UILabel!
  @IBOutlet weak var cityLBL: UILabel!
  @IBOutlet weak var zipcodeLBL: UILabel!
  @IBOutlet weak var hobbiesLBL: UILabel!
  @IBOutlet weak var friendsLBL: UILabel!
  
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
    self.configureView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

