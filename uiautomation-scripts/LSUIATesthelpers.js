/*
 *  LSUIATesthelpers.js
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
 * Helpers/ utility functions that implement the test cases
 */
#import "tuneup/tuneup.js"
#import "tuneup/assertions.js"
#import "LSUIATestglobals.js"

function accountLogin (target,app) {
	var window = app.mainWindow();
	
	// -- Log elements of tree
	window.logElementTree();

	var table = window.tableViews()[0];

	// -- Set the email/password 
	var login = table.cells()[0].elements()["Enter Login Name"];
	var pass = table.cells()[1].elements()["Enter Password"];
	login.setValue(lsUITester.login());
	pass.setValue (lsUITester.password());

	// -- Dismiss keyboard 
	app.keyboard().buttons()["Done"].tap();

	// Tap login button
	var loginbutton = window.buttons()["Login"];
	loginbutton.tap();

}



function addNewTask(target,app){
	var window = app.mainWindow();
	
	// -- Access the Add button
    var navbar = app.navigationBar();
    var addButton = navbar.rightButton();

    // -- Tap the add button to bring up add Task screen
	addButton.tap();

	// verify Add Task Screen is loaded
	var addTaskWindow = verifyAddTaskScreenLoaded(target,app);

	// Add a task entry
	var table = addTaskWindow.tableViews()[0];
	var taskEntry = table.cells()[0].elements()["Enter Task"];
	taskEntry.setValue(lsUITester.taskDescription());
	
	// -- Dismiss keyboard 
	app.keyboard().buttons()["Return"].tap();

	
	// Set due date
	var dueDateEntry = table.cells()[1].elements()["Enter Due Date"];
	dueDateEntry.tap();
    
    // Tap on cell again to dismiss the date picker
    var dueDateEntry = table.cells()[1].elements()["Enter Due Date"];
    dueDateEntry.tap();
	
	 // -- Tap the done button to complete addition of the task
	navbar = app.navigationBar();
    doneButton = navbar.rightButton();
	doneButton.tap();

}


function deleteTask(target,app){
	
    var taskListWindow = verifyTaskListScreenLoaded(target,app);

 	var table = taskListWindow.tableViews()[0];
	
 	// Assert number of rows in table is non zero
	assertNotEquals(table.cells().length,0);

	// delete first task
	var cell = table.cells()[0];
    

	// swipe the cell (works ONLY on devices)
	cell.dragInsideWithOptions({startOffset:{x:0.5, y:0.3}, endOffset:{x:0.1, y:0.3}, duration:1.5});

	UIATarget.localTarget().pushTimeout(1);
	
	// delete button will show up. 
	var deleteButton = cell.buttons()[0];

	assertNotNull(deleteButton);
    
	UIATarget.localTarget().popTimeout();

	deleteButton.tap();

	
}


function accountLogout (target,app) {
	var window = app.mainWindow();
	
	// -- Log elements of tree
	window.logElementTree();

	// -- Access the Add button
    var navbar = app.navigationBar();
    var logoutButton = navbar.leftButton();

    // -- Tap the log out button to bring up LogIn screen
	logoutButton.tap();

	
}


function verifyLoginScreenLoaded(target,app) {
	var window = app.mainWindow();
	// Log element tree
	window.logElementTree();
	
	UIATarget.localTarget().pushTimeout(1);	
	
	var table = window.tableViews()[0];
	// Assert number of rows in table is as expected
	assertEquals(table.cells().length,2);

	assertWindow ({
			
			tableViews: [{
     	 	cells: [
     	 		{name:"Enter Login Name"},
     	 		{name:"Enter Password"}
     	 	]}],
     	 	buttons:[{name:"Login"}],
  	  onPass:function(window) {
  		}
   	});

	UIATarget.localTarget().popTimeout();
	return window;
}

function verifyTaskListScreenLoaded(target,app) {
	var window = app.mainWindow();
	// Log element tree
	window.logElementTree();

	// -- Wait for upto 1 seconds 
 	
	UIATarget.localTarget().pushTimeout(1);	
	// Identifying the screen through the nav bar title 
	assertEquals(app.navigationTitle(),"Tasks");
	
	// Confirming presence of Add right hand button &left log out button
	var navbar = app.navigationBar();
	navbar.assertRightButtonNamed ("Add Task");
	navbar.assertLeftButtonNamed ("Log Out");

	var table = window.tableViews()[0];
	
 	// Assert number of rows in table is as expected (which is # of tasks added so far)
	//assertEquals(table.cells().length,lsUITester.numTasks());
	UIATarget.localTarget().popTimeout();	
    return window;


}

function verifyAddTaskScreenLoaded(target,app) {
	var window = app.mainWindow();
	// Log element tree
	window.logElementTree();

	// -- Wait for upto  3 seconds 
	UIATarget.localTarget().pushTimeout(1);	
	
 	// Identifying the screen through the nav bar title 
	assertEquals(app.navigationTitle(),"Add Task");

	UIATarget.localTarget().popTimeout();
	
	// Confirming presence of Cancel button to left and DOne on right
	var navbar = app.navigationBar();
	navbar.assertLeftButtonNamed ("Cancel Add Task");
	navbar.assertRightButtonNamed ("Confirm Add Task");

	assertWindow ({
			
			tableViews: [{
     	 	cells: [
     	 		{name:"Enter Task"},
     	 		{name:"Enter Due Date"}]}
     	 	],
  	  onPass:function(window) {
  		}
   	});

	return window;
}

