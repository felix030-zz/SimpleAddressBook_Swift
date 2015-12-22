//
//  DetailViewController.swift
//  Ue5_6-Klemke-Fiebig
//
//  Created by Felix E.C. Klemke & Julian Fiebig on 11/12/15.
//  Copyright © 2015 Felix Klemke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  
  @IBOutlet weak var txfName: UITextField!
  @IBOutlet weak var txfSurname: UITextField!
  @IBOutlet weak var txfStreet: UITextField!
  @IBOutlet weak var txfNbr: UITextField!
  @IBOutlet weak var txfZip: UITextField!
  @IBOutlet weak var txfCity: UITextField!
  
  @IBOutlet weak var lblName: UILabel!
  @IBOutlet weak var lblSurname: UILabel!
  @IBOutlet weak var lblStreet: UILabel!
  @IBOutlet weak var lblNbr: UILabel!
  @IBOutlet weak var lblZip: UILabel!
  @IBOutlet weak var lblCity: UILabel!
  
  var detailItem: AnyObject? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let detail = self.detailItem {
      if let label = self.detailDescriptionLabel {
        label.text = detail.description
      }
    }
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
  
  @IBAction func test(sender: UIBarButtonItem) {
    
  }
  
  
  
}

