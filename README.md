# iOS-UIAutomationExample
This simple app demonstrates how you can automate the UI testing of your app using Apple's UIAutomation JS library.
This app is a swift reboot of the corresponding ObjC version I had developed/demoed in the pre-iOS7/ pre-XCode5 days.
The swift version continues to leverage some of the ObjC classes using Swift-ObjC bridging facility.

For a primer on UIAutomation testing , please check out this short talk that I gave at Cocoaheads couple of years ago -http://www.priyaontech.com/download/17/

With the announcement of iOS9 and brand new UI Testing features, the need for JS based UI Automation testing is questionable.
However, if you need to automate the UI testing of  apps that need to support iOS8 and earlier, the UI Automation framework 
is a great alternative. 

You will have to run the tests on an actual device. There appears to be a Xcode bug which causes certain functions like
dragInsideWithOptions to fail on simulators.


The UI AUtomation Script Files:
--------------------------------
- LSUIATestcases.js : This file defines the main test cases to be executed against the app
- LSUIATesthelpers.js: This file includes the functions that perform the tests and is used by LSUIATestcases.js
- LSUIATestglobals.js: This file defines the global data input
- tuneup/*.* : The files in this folder include a set of third party, open source extensions to the UI Automations interface. They greatly simplify writng of the test scripts and are used by the LSUIATest* files. More info on tuneup.js from https://github.com/alexvollmer/tuneup_js.



How to run the tests ?
---------------------------
1)With your app project open in Xcode, select "profile" option from the "Product" menu. This will launch Instruments with your app as the target.

2) Make sure you select the "Automations" tool when Instruments is launched.

3) If you are testing on your device, make sure you enable UI Automation testing on Device . Settings -> Developer-> Enable UI Automation

4) Import the LSUIATestcases.js test file into the Apple Instruments UI Automations tool. You can find more details on how to import test scripts at https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/UsingtheAutomationInstrument/UsingtheAutomationInstrument.html#//apple_ref/doc/uid/TP40004652-CH20-SW2.

4)Confirm the Target (Device/Simulator) and Target Process (in this case, "LSUIAExample" ) in Instruments using the "target" menu.

5)Tap "Record" to execute the tests
