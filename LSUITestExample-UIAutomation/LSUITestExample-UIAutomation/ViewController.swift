//
//  ViewController.swift
//  LSUITestExample-UIAutomation
//
//  Created by Priya Rajagopal on 6/10/15.
//  Copyright (c) 2015 lunaria. All rights reserved.
//

import UIKit

// KVO const
let LOGIN_SUCCESS:String = "LoginSuccess"

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    // MARK - instance var declarations
    let NUMSECTIONS = 1
    let NUMROWSPERSECTION = 2
    let ROW_HEIGHT:CGFloat = 55.0
    let ROWINDEX_LOGIN = 0
    let ROWINDEX_PASSWORD = 1
    
    let TAG_LOGIN = 10
    let TAG_PASSWORD = 20

    
    @IBOutlet weak var loginTableView: UITableView!
    @IBOutlet  var loginButton: UIButton!
    
    
    weak var loginTextField: UITextField!
    weak var passTextField: UITextField!
    var  accountManager: LSAccountDataManager {
        get{
            return LSAccountDataManager.sharedInstance()
        }
    }
    
    dynamic var LoginSuccess:Bool = true
    dynamic var LogoutSuccess:Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loginTableView.rowHeight = ROW_HEIGHT
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK -- UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return NUMROWSPERSECTION
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == ROWINDEX_LOGIN {
            let cell :UITableViewCell  = tableView.dequeueReusableCellWithIdentifier("LoginCell")! as! UITableViewCell
            self.loginTextField = cell.contentView.viewWithTag(TAG_LOGIN) as! UITextField
            self.loginTextField.becomeFirstResponder()
            self.loginTextField.delegate = self
            return cell
        }
        else {
           let cell :UITableViewCell  = tableView.dequeueReusableCellWithIdentifier("PasswordCell")! as! UITableViewCell
            self.passTextField = cell.contentView.viewWithTag(TAG_PASSWORD) as! UITextField
            self.passTextField.delegate = self
            return cell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return NUMSECTIONS
    }
    
    // MARK - UITableViewDelegate
    
    
    // MARK - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
  
        if self.loginTextField.text!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 &&
        self.passTextField.text!.lengthOfBytesUsingEncoding( NSUTF8StringEncoding) > 0 {
                self.loginButton.enabled = true
        }
        if (textField == self.loginTextField)
        {
            self.passTextField.becomeFirstResponder()
        }
        else
        {
            textField.resignFirstResponder()
        }
        return true
     }


 
    // MARK - IBAction
    @IBAction func onLoginTapped(sender: UIButton) {
        let user = self.loginTextField.text!
        let pass = self.passTextField.text!
        
        self.LoginSuccess = self.accountManager.isValidUser(user, withPassword: pass)
    }
    
  

}

