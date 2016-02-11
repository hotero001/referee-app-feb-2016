/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CoreData

protocol JournalEntryDelegate {
  
  func didFinishViewController(
    viewController:JournalEntryViewController, didSave:Bool)
  
}

class JournalEntryViewController: UITableViewController {
    
  @IBOutlet weak var heightTextField: UITextField!
  @IBOutlet weak var periodTextField: UITextField!
  @IBOutlet weak var windTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var ratingSegmentedControl:
    UISegmentedControl!
    
    //score stepper variable naming
    @IBOutlet weak var homeStepper: UIStepper!
    @IBOutlet weak var awayStepper: UIStepper!
    
    //variables declaring buttons for enabling and disabling score change
    @IBOutlet weak var changeScoreButton: UIButton!
    @IBOutlet weak var doneChangingScoreButton: UIButton!
    
    //variables declaring scores
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    
    //variables declaring home yellow and home red text fields
    @IBOutlet weak var homeYellowTextField: UITextField!
    @IBOutlet weak var homeRedTextField: UITextField!
    
    //variable declaring submit button for the home yellow and home red text fields
    @IBOutlet weak var submitHomeYellowButton: UIButton!
    @IBOutlet weak var submitHomeRedButton: UIButton!
    
    //variables declaring labels to be filled with text of home yellow and home red cards
    @IBOutlet weak var homeYellowLabel: UILabel!
    @IBOutlet weak var homeRedLabel: UILabel!
    
    //variables declaring submit button for the away yellow and away red text fields
    @IBOutlet weak var submitAwayYellowButton: UIButton!
    @IBOutlet weak var submitAwayRedButton: UIButton!
    
    //variables declaring labels to be filled with text of away yellow and red cards
    @IBOutlet weak var awayYellowLabel: UILabel!
    @IBOutlet weak var awayRedLabel: UILabel!
    
    //variables declaring away yellow and away red text fields
    @IBOutlet weak var awayYellowTextField: UITextField!
    @IBOutlet weak var awayRedTextField: UITextField!
    
    
  var journalEntry: JournalEntry! {
    didSet {
      self.configureView()
    }
  }
    
  var context: NSManagedObjectContext!
  var delegate:JournalEntryDelegate?

  //variables declaring the arrays for bookings
  //var homeYellows = [String]()
  var homeYellows = [String]()
  var homeReds = [String]()
  var awayYellows = [String]()
  var awayReds = [String]()
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
    
    homeStepper.enabled = false
    awayStepper.enabled = false
    homeStepper.wraps = true
    awayStepper.wraps = true
    
    doneChangingScoreButton.enabled = false
    doneChangingScoreButton.hidden = true
    
    //homeYellowLabel.text = "---"
    //homeRedLabel.text = "---"
  }
  
  
  // MARK: View Setup
  
  func configureView() {
    
    title = journalEntry.stringForDate()
    
    if let textField = heightTextField {
      if let value = journalEntry.height {
        textField.text = value
      }
    }
    
    if let textField = periodTextField {
      if let value = journalEntry.period {
        textField.text = value
      }
    }
    
    if let textField = windTextField {
      if let value = journalEntry.wind {
        textField.text = value
      }
    }
    
    if let textField = locationTextField {
      if let value = journalEntry.location {
        textField.text = value
      }
    }
    
    //home score
    if let textField = homeScoreLabel {
        if let value = journalEntry.homeScore {
            textField.text = "\(value)"
        }
    }
    
    //away score
    if let textField = awayScoreLabel {
        if let value = journalEntry.awayScore {
            textField.text = "\(value)"
        }
    }
    
    //home yellow listings
    if let textField = homeYellowLabel {
        if let value = journalEntry.homeYellowListing {
            textField.text = "\(value)"
        }
    }
    
    //home red listings
    if let textField = homeRedLabel {
        if let value = journalEntry.homeRedListing {
            textField.text = value
        }
    }
    
    //away yellow listings
    if let textField = awayYellowLabel {
        if let value = journalEntry.awayYellowListing {
            textField.text = value
        }
    }
    
    //away red listings
    if let textField = awayRedLabel {
        if let value = journalEntry.awayRedListing {
            textField.text = value
        }
    }
    
    if let segmentControl = ratingSegmentedControl {
      if let rating = journalEntry.rating {
        segmentControl.selectedSegmentIndex =
          rating.integerValue - 1
      }
    }
    
  }
  
  func updateJournalEntry() {
    
    if let entry = journalEntry {
      entry.date = NSDate()
      entry.height = heightTextField.text
      entry.period = periodTextField.text
      entry.wind = windTextField.text
      entry.location = locationTextField.text
      //home and away scores
      entry.homeScore = Int(homeScoreLabel.text!)
      entry.awayScore = Int(awayScoreLabel.text!)
      
      entry.homeYellowListing = homeYellowLabel.text
      entry.homeRedListing = homeRedLabel.text!
        
      //uncomment below two lines
      entry.awayYellowListing = awayYellowLabel.text
      entry.awayRedListing = awayRedLabel.text
        
      entry.rating =
        NSNumber(integer:
          ratingSegmentedControl.selectedSegmentIndex + 1)
    }
  }
  
  
  // MARK: Target Action
  
  @IBAction func cancelButtonWasTapped(sender: AnyObject) {
    delegate?.didFinishViewController(self, didSave: false)
  }
  
  @IBAction func saveButtonWasTapped(sender: AnyObject) {
    updateJournalEntry()
    delegate?.didFinishViewController(self, didSave: true)
  }
  
    @IBAction func changeScoreAction(sender: AnyObject) {
        doneChangingScoreButton.hidden = false
        doneChangingScoreButton.enabled = true
        changeScoreButton.hidden = true
        changeScoreButton.enabled = false
        
        homeStepper.enabled = true
        awayStepper.enabled = true
    }
    
    @IBAction func doneChangingScoreAction(sender: AnyObject) {
        changeScoreButton.hidden = false
        changeScoreButton.enabled = true
        doneChangingScoreButton.hidden = true
        doneChangingScoreButton.enabled = false
        
        homeStepper.enabled = false
        awayStepper.enabled = false
    }
    
    @IBAction func editHomeScoreAction(sender: UIStepper) {
        if journalEntry.homeScore == 0 {
            homeScoreLabel.text = Int(sender.value).description
        }else{
            homeScoreLabel.text = (Int(sender.value)+Int(journalEntry.homeScore!)).description
        }
    }
    
    @IBAction func editAwayScoreAction(sender: UIStepper) {
      if journalEntry.awayScore == 0 {
        awayScoreLabel.text = Int(sender.value).description
      }else {
        awayScoreLabel.text = (Int(sender.value) + Int(journalEntry.awayScore!)).description
      }
    }
    
    //action to submit the player number for a home yellow booking
    @IBAction func submitHomeYellowAction(sender: AnyObject) {
        if homeYellows.contains(homeYellowTextField.text!){
            if homeReds.contains(homeYellowTextField.text!){
            }else{
                homeReds.append(homeYellowTextField.text!)
                homeRedLabel.text = "\(homeReds)"
            }
        }else{
            self.homeYellows.append(homeYellowTextField.text!)
        }
        homeYellowLabel.text = String(homeYellows) + String(journalEntry.homeYellowListing!)
    }
    
    //action to submit the player number for a home red booking
    @IBAction func submitHomeRedAction(sender: AnyObject) {
        if homeReds.contains(homeRedTextField.text!){
        }else{
            homeReds.append(homeRedTextField.text!)
        }
        if journalEntry.homeRedListing != nil {
            homeRedLabel.text = String(homeReds) + String(journalEntry.homeRedListing!)
        }else{
            homeRedLabel.text = String(homeReds)
        }
    }
    
    @IBAction func submitAwayYellowAction(sender: AnyObject) {
        if awayYellows.contains(awayYellowTextField.text!) {
            if awayReds.contains(awayYellowTextField.text!) {
            }else {
                awayReds.append(awayYellowTextField.text!)
                awayRedLabel.text = String(awayReds)
            }
        }else{
            self.awayYellows.append(awayYellowTextField.text!)
            //awayYellowLabel.text = "\(awayYellows)"
        }
        awayYellowLabel.text = String(awayYellows) + String(journalEntry.awayYellowListing!)
    }
  
    @IBAction func submitAwayRedAction(sender: AnyObject) {
        if awayReds.contains(awayRedTextField.text!) {
        }else{
            awayReds.append(awayRedTextField.text!)
        }
        if journalEntry.awayRedListing != nil {
            awayRedLabel.text = String(awayReds) + String(journalEntry.awayRedListing!)
        }else{
            awayRedLabel.text = String(awayReds)
        }
    }
}




