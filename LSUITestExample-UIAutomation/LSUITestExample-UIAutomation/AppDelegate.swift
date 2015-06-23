//
//  AppDelegate.swift
//  LSUITestExample-UIAutomation
//
//  Created by Priya Rajagopal on 6/10/15.
//  Copyright (c) 2015 lunaria. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
  //  var loginController:ViewController!
   // var taskListController:LSTaskListViewController?

    private var myContext = 0

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let navVC = self.window!.rootViewController as! UINavigationController
        if navVC.topViewController.isKindOfClass( ViewController) {
            let loginVC = navVC.topViewController as! ViewController
            self.addLoginVCObservers(loginVC)
        }

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

    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [NSObject : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == LOGIN_SUCCESS && context == &myContext {
            let loginStatus  = change?[NSKeyValueChangeNewKey]!.boolValue
            if loginStatus == true {
                self.showTaskViewController()
            }
            else {
                let alertVC = UIAlertController(title: "Login Error", message: "Failed to Login. Please check your input and try again", preferredStyle:.Alert)
                let action = UIAlertAction(title: "OK", style: .Cancel, handler: { (actionVal) -> Void in
                    alertVC.dismissViewControllerAnimated( false, completion: nil)
                })
                alertVC.addAction( action)
                
                self.window!.rootViewController!.presentViewController(alertVC, animated: false, completion: { () -> Void in
                    
                })
                
            }
        }
        else if keyPath == LOGOUT_SUCCESS && context == &myContext {
              self.showLoginViewController()
           
        }
        else {
            super.observeValueForKeyPath(keyPath!,ofObject:object!,change:change!,context: context)
        }
    }
    
    func showTaskViewController() {
        let navVC = self.window!.rootViewController as! UINavigationController
        
        if navVC.topViewController.isKindOfClass(ViewController) {
            let loginVC = navVC.topViewController as! ViewController
            self.removeLoginVCObservers(loginVC)
            
            let storyboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
            let taskNVC = storyboard.instantiateViewControllerWithIdentifier("TasksNVC") as! UINavigationController
            let taskVC = taskNVC.topViewController as! LSTaskListViewController
            
            self.addTaskListVCObservers(taskVC)
            self.window!.rootViewController = taskNVC
        }
        
    }
    
    func showLoginViewController() {
        let navVC = self.window!.rootViewController as! UINavigationController
        
        if navVC.topViewController.isKindOfClass(LSTaskListViewController)  {
            
            let taskVC = navVC.topViewController as! LSTaskListViewController
            self.removeTaskListVCObservers(taskVC)
            
            let storyboard = UIStoryboard(name:"Main", bundle: NSBundle.mainBundle())
            let loginNVC = storyboard.instantiateViewControllerWithIdentifier("LoginNVC") as! UINavigationController
            let loginVC = loginNVC.topViewController as! ViewController
            
            self.addLoginVCObservers(loginVC)
          
            self.window!.rootViewController = loginNVC
        }
    }
    
    func addLoginVCObservers(loginVC:ViewController){
        loginVC.addObserver(self, forKeyPath: LOGIN_SUCCESS, options: .New, context: &myContext)
    }
    
    
    func removeLoginVCObservers(loginVC:ViewController){
        loginVC.removeObserver(self, forKeyPath: LOGIN_SUCCESS, context: &myContext)
    }
    
    func addTaskListVCObservers(taskVC:LSTaskListViewController){
        taskVC.addObserver(self, forKeyPath: LOGOUT_SUCCESS, options: .New, context: &myContext)
    }
    
    
    func removeTaskListVCObservers(taskVC:LSTaskListViewController){
        taskVC.removeObserver(self, forKeyPath: LOGOUT_SUCCESS, context: &myContext)
        
    }
    
    
    

}

