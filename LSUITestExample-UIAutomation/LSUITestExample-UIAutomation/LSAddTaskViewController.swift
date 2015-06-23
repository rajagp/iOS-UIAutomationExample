//
//  LSAddTaskViewController.swift
//  LSUITestExample-UIAutomation
//
//  Created by Priya Rajagopal on 6/14/15.
//  Copyright (c) 2015 lunaria. All rights reserved.
//

import Foundation
import UIKit

class LSAddTaskViewController :UITableViewController, UIPickerViewDelegate, UITextViewDelegate
{
    let ROW_HEIGHT:CGFloat = 45.0
    let ROW_INDEX_TASKDETAILS = 0
    let SECTION_INDEX_DATEPICKER = 1
    var datePickerCellHeight:CGFloat = 45.0
    
    @IBOutlet var dueDate: UILabel!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var taskDetailsTextView: UITextView!
    @IBOutlet var datePickerView: UIView!
    @IBOutlet var datePickerZeroHeightConstraint: NSLayoutConstraint!
    @IBOutlet var datePicker: UIDatePicker!
    
    var dataManager:LSTaskDataManager {
        get{
            return LSTaskDataManager.sharedInstance()
        }
    };
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = ROW_HEIGHT
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.datePickerView.hidden = true
        self.datePickerView.addConstraint(datePickerZeroHeightConstraint)
     
        let dateVal = NSDateFormatter.localizedStringFromDate(self.datePicker.date, dateStyle:.ShortStyle, timeStyle:.ShortStyle)
        self.dueDate.text = dateVal;
        
        self.datePicker.minimumDate = NSDate()
        
        
    }
    
    // MARK - UITableViewDataSOurce
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height = ROW_HEIGHT
        if indexPath.section == SECTION_INDEX_DATEPICKER {
           return self.datePickerCellHeight
        }
        return height
    }
    
  
    
    // MARK - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            self.datePickerView.hidden = !self.datePickerView.hidden
            if self.datePickerView.hidden {
                self.datePicker.hidden = true
                self.datePickerView.addConstraint(datePickerZeroHeightConstraint)
             }
            else {
                self.datePicker.hidden = false
                self.datePickerView.removeConstraint(datePickerZeroHeightConstraint)
                
            }
            let dateVal = NSDateFormatter.localizedStringFromDate(self.datePicker.date, dateStyle:.ShortStyle, timeStyle:.ShortStyle)
            self.dueDate.text = dateVal;
            
            cell.setNeedsUpdateConstraints()
            
            cell.setNeedsLayout()
         
            self.datePickerCellHeight = cell.contentView.systemLayoutSizeFittingSize(CGSizeMake(self.tableView.bounds.size.width, 0), withHorizontalFittingPriority: 1000.0, verticalFittingPriority: 749.0).height
            tableView.beginUpdates()
            tableView.endUpdates()

            
        }
    }
    
    // MARK - UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        self.saveButton.enabled = count(textView.text.utf16) > 0
    }
    // MARK - IBActions
    
    @IBAction func onSaveTapped(sender: UIBarButtonItem) {
        let task:LSTask = LSTask(detail:self.taskDetailsTextView.text, andDueDate: self.datePicker.date)
        self.dataManager.addTask(task)
       self.performSegueWithIdentifier("unwind", sender: self)
          
    }
    

}