/*
 *  LSUIATestglobals.js
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
 * Globals  scoped within lsUITester namespace ("modular pattern")
 */

var lsUITester = (function() {
   
	var _gLogin="admin";
	var _gPassword="admin";
    var _gTasks = [];
    var _gNumTasks = 0;
    var _gTaskDescription="This is a test task";
    var _gTaskDueDate="1380489425";
	    return {
        
        login: function() {
            return _gLogin;     
        },
        password: function() {
            return _gPassword;     
        },
         setLogin: function(val) {
            _gLogin = val;     
        },

        setPassword: function(val) {
            _gPassword = val;     
        },
        taskDescription: function() {
            return _gTaskDescription;     
        },
        taskDueDate: function() {
            return _gTaskDueDate;     
        },
        setTaskDescription: function(val) {
            // Every time a new task description is added, we update the tasks array as well as the task count
            _gTaskDescription = val;  
            if (_gTasks == null)
            {
                _gTasks = new Array();
            }   
            _gTasks.push(val);
            _gNumTasks++;
        },
        setTaskDueDate: function(val) {
            _gTaskDueDate = val;     
        },
        removeTaskAtIndex: function(index) {
            if (_gNumTasks >= index)
            {
                _gTasks.splice(index,1);
                _gNumTasks--;  
            }   
        },
        numTasks: function() {
            return _gNumTasks;     
        },
        tasks: function() {
            return _gTasks;     
        },
    };  
})(lsUITester);  

