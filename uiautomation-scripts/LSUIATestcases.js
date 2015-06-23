/*
 *  LSUIATestcases.js
 *
 *  Created by Priya Rajagopal on 9/23/13.
 *  Copyright (c) 2013 Lunaria Software, LLC. All rights reserved.
 *  Redistribution and use in source and binary forms, with or without modification,
 *  are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * Main test Script : Must be imported by Apple Instruments Automations tool.
 * All test cases are declared using the test function defined in tuneup.js. The
 * test function accepts a name for the test and corresponding test function 
 */

#import "tuneup/tuneup.js"
#import "tuneup/assertions.js"
#import "LSUIATesthelpers.js"


/*
	The current set of test cases work for the iPhone version of the app. 
	All tests have the same basic structure:
		- Confirm the current state (view) from where test is to be executed
		- Perform test
		- Confirm the test results by checking the new state (view) post test after test is executed
		- Capture screenshot
		In some cases, steps 2 and 3 may be merged into a single function if it makes logical sense
*/

// -- Generic alert handler
UIATarget.onAlert = function onAlert(alert){
	UIALogger.logMessage("alert handler invoked"+ alert.logElementTree());

	var alertTitle= alert.name();
	var alertMessage = alert.staticTexts()[1].name();

	// For every alert message that we want to handle, return true
	if ( alertTitle == "Login Error")
	{
		UIALogger.logMessage("custom handler invoked");
		return true;
	}
	// Pass the rest to default handler
	return false;
    
}

// -- Test to verify if login fails with an invalid set of credentials
test("TestUnsuccessfulLogin",function(target,app){
	
	// Set fake credentials
	lsUITester.setLogin("wronguser");
	lsUITester.setPassword("wongpassword");


	// verify we are on  login screen
 	verifyLoginScreenLoaded(target,app);
 	
	// Perform login operation
	accountLogin (target,app);

	// verify results of the test
	// -- Wait for 5 seconds for alert to be displayed with textbox
 	UIATarget.localTarget().pushTimeout(5);		
	
	// -- COnfirm that an error alert is displayed and login is not permitted	
	var alertTitle= app.alert().name();
    var alertMessage = app.alert().staticTexts()[1].name();	
    var okButton = app.alert().buttons()["OK"];
    

    // -- dismiss alert
    assertEquals(alertTitle,"Login Error");
    okButton.tap();
    UIATarget.localTarget().popTimeout();

	
	//capture a screenshot with a specified name
	UIATarget.localTarget().captureScreenWithName("TestUnsuccessfulLogin");

});

// -- Test to verify if login succeeds with a valid set of credentials
test("TestSuccessfulLogin",function(target,app){
	
	// Set valid credentials
	lsUITester.setLogin("admin");
	lsUITester.setPassword("admin");


	// Perform login operation
	accountLogin (target,app);

	// verify results of the test
	// -- Wait for alert to be displayed with textbox
 	verifyTaskListScreenLoaded (target,app);	
  
	//capture a screenshot with a specified name
	UIATarget.localTarget().captureScreenWithName("TestSuccessfulLogin");

});

// -- Test to verify addition of 'N' new tasks
test("TestAddMultipleTaskFunction",function(target,app){
	
	for (var i = 0 ; i < 1; i++) {
     // Confirm we are on right screen
     verifyTaskListScreenLoaded(target,app);
     

	UIALogger.logMessage("Will add task # "+ i);

	
	//  task to be added
	lsUITester.setTaskDescription("This is my Task Item "+i);
	
	// Perform addition of task
	addNewTask (target,app);


	}
    //capture a screenshot with a specified name
	UIATarget.localTarget().captureScreenWithName("TestAddMultipleTaskFunction");

});

/*
// -- Test to verify cancellation of addition of a new task
test("TestCancelTaskFunction",function(target,app){
	
	// Confirm we are on right screen
	verifyAddTaskScreenLoaded(target,app);

	// Attempt addition  of task (which will subsequently be cancelled)
	cancelNewTask (target,app);

	// wait for a few seconds
	UIATarget.localTarget().delay(3);
	
	// verify results of the add task operation
 	verifyTaskListScreenLoaded (target,app);
 	
	//capture a screenshot with a specified name
	UIATarget.localTarget().captureScreenWithName("TestCancelTaskFunction");



});
 */

// -- Test to verify deletion of  a task
test("TestDeleteTaskFunction",function(target,app){
	
     // wait for a few seconds
     UIATarget.localTarget().delay(3);
     
	// Confirm we are on right screen
	verifyTaskListScreenLoaded(target,app);


	lsUITester.removeTaskAtIndex(0);

	// Attempt deletion  of task 
	deleteTask (target,app);

	// wait for a few seconds
	UIATarget.localTarget().delay(3);
	
	// verify results of the delete task operation
 	verifyTaskListScreenLoaded (target,app);
 	
	//capture a screenshot with a specified name
	UIATarget.localTarget().captureScreenWithName("TestDeleteTaskFunction");


});

// -- Test to verify Log Out Operation
test("TestLogoutTaskFunction",function(target,app){
	
	// Confirm we are on right screen
	verifyTaskListScreenLoaded(target,app);

	// Attempt addition  of task
	accountLogout (target,app);

	// verify results of the verify log out operation
 	verifyLoginScreenLoaded(target,app);
 	
	//capture a screenshot with a specified name
	UIATarget.localTarget().captureScreenWithName("TestLogoutTaskFunction");

});


