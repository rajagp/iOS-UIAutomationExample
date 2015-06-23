//
//  LSTaskListViewController.swift
//  LSUITestExample-UIAutomation
//
//  Created by Priya Rajagopal on 6/11/15.
//  Copyright © 2015 lunaria. All rights reserved.
//

import Foundation
import UIKit

let LOGOUT_SUCCESS:String = "logOutSuccess"

class LSTaskListViewController : UITableViewController {
    
    let NUMSECTIONS = 1
    let ROW_HEIGHT:CGFloat = 55.0
    
  
    var addController:LSAddTaskViewController!
    
    var dataManager:LSTaskDataManager {
        get{
            return LSTaskDataManager.sharedInstance()
        }
    };
    dynamic var logOutSuccess:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = ROW_HEIGHT
        self.tableView.rowHeight = UITableViewAutomaticDimension
         
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    // MARK -- UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataManager.numTasks
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let taskDetail:LSTask = self.dataManager.taskList[indexPath.row] as! LSTask
            self.dataManager.removeTaskWithId(taskDetail.requestId)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell :UITableViewCell  = tableView.dequeueReusableCellWithIdentifier("TaskCell")! as! UITableViewCell
        let taskDetail:LSTask = self.dataManager.taskList[indexPath.row] as! LSTask
        cell.textLabel!.text = taskDetail.detail
        cell.detailTextLabel!.text = NSDateFormatter.localizedStringFromDate( taskDetail.dueDate, dateStyle: .ShortStyle, timeStyle: .ShortStyle)
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return NUMSECTIONS
    }
    
    // MARK - IBAction
    @IBAction func unwindToTaskList(segue:UIStoryboardSegue) {
        
    }

    @IBAction func logoutTapped(sender: UIBarButtonItem) {
        self.logOutSuccess = true
    }

}