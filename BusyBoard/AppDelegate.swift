//
//  AppDelegate.swift
//  BusyBoard
//
//  Created by Tom Bernard on 5/5/15.
//  Copyright (c) 2015 Bersearch Information Services. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var busyBoardWindowController: BusyBoardWindowController?


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        let busyBoardWindowController = BusyBoardWindowController()
        
        // put the BusyBoard window on the screen
        busyBoardWindowController.showWindow(self)
        
        // set the property to point to the window controller
        self.busyBoardWindowController = busyBoardWindowController
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

