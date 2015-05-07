//
//  BusyBoardWindowController.swift
//  BusyBoard
//
//  Created by Tom Bernard on 5/5/15.
//  Copyright (c) 2015 Bersearch Information Services. All rights reserved.
//

import Cocoa

class BusyBoardWindowController: NSWindowController {

    // outlets
    
    @IBOutlet weak var slider: NSSlider!
    @IBOutlet weak var radioGroup: NSMatrix!
    @IBOutlet weak var sliderStatusTextField: NSTextField!
    
    @IBOutlet weak var checkBox: NSButton!
    
    @IBOutlet weak var passwordTextField: NSTextField!
    @IBOutlet weak var clearTextField: NSTextField!
    @IBOutlet weak var revealButton: NSButton!
    
    @IBOutlet weak var colorWell: NSColorWell!
    @IBOutlet weak var redTextField: NSTextField!
    @IBOutlet weak var greenTextField: NSTextField!
    @IBOutlet weak var blueTextField: NSTextField!
    
    // variables
    
    // slider variables - initialized here to 0 - initialized from slider in windowDidLoad() and saveInitialControlSettings()
    var initialSliderValue: Double = 0
    var sliderValue: Double = 0
    var oldSliderValue: Double = 0
    
    // radio group variables
    var initialRadioButtonState: Int = 0
    
    // password variables - initialized here to "" - initialized from password text field in windowDidLoad() and saveInitialControlSettings()
    var initialPasswordString = ""
    var passwordStr = ""
    var revealPassword = false
    var initialRevealPassword = false
    
    // check box variables
    var initialCheckBoxState = NSOffState
    
    override var windowNibName: String? {
        return "BusyBoardWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        self.saveInitialControlSettings()
        
        
        // initialize UI
        
        // initialize slider variables
        oldSliderValue = slider.doubleValue
        
        self.adjustSliderValue(slider)              // initializes slider status text field
        self.radioGroupChanged(radioGroup)          // conforms slider tick display to radio buttons unpacked from nib
        
        // radio buttion selection
        
        
        // initialize password variables
        passwordStr = passwordTextField.stringValue
        // revealPassword = false                   // initialized above to false - no need to init it again
        
        
        
        
    }
    
    func saveInitialControlSettings() {
        
        // slider
        initialSliderValue = slider.doubleValue
        
        // radio group
        initialRadioButtonState = radioGroup.selectedRow
        
        // password
        initialPasswordString = passwordTextField.stringValue
        initialRevealPassword = revealPassword
        
        // check box
        initialCheckBoxState = checkBox.state
        
        
        
    }
    
    // reset controls
    
    @IBAction func resetControls(sender: NSButton)
    {
        // slider
        slider.doubleValue = initialSliderValue
        oldSliderValue = initialSliderValue
        self.adjustSliderValue(slider)
        
        // radio group
        radioGroup.selectCellAtRow(initialRadioButtonState, column:0)
        self.radioGroupChanged(radioGroup)
        
        // password
        passwordTextField.stringValue = initialPasswordString
        
        // we set revealPassword to the opposite of initialRevealPassword - the action 
        // method will negate revealPassword
        revealPassword = !initialRevealPassword
        self.revealButtonPressed(revealButton)
        
        // check box
        checkBox.state = initialCheckBoxState
        self.checkBoxChanged(checkBox)
    }
    
    
    
    // slider action method
    
    @IBAction func adjustSliderValue(sender: NSSlider) {
        sliderValue = sender.doubleValue;
//        NSLog("sliderValue = \(sliderValue)")
        
        if (sliderValue > oldSliderValue) {
            sliderStatusTextField.stringValue = "slider is going up"
        }
        
        if sliderValue < oldSliderValue {
            sliderStatusTextField.stringValue = "slider is going down"
        }
        
        if sliderValue == oldSliderValue {
            sliderStatusTextField.stringValue = "slider is unchanged"
        }
        
        oldSliderValue = sliderValue
    }
    
    
    // radioGroup action method
    
    @IBAction func radioGroupChanged(sender: NSMatrix) {
        NSLog("radioGroupChanged(_:)")
        
        var row = sender.selectedRow
        // var column = sender.selectedColumn
        
        if row == 0 {
            // show ticks
            slider.numberOfTickMarks = 11
        }
        
        if row == 1 {
            // do not show ticks
            slider.numberOfTickMarks = 0
        }
    }
    
    
    // checkBox action method
    
    @IBAction func checkBoxChanged(sender: NSButton) {
//        NSLog("checkBoxChanged(_:)")
        
        var state: Int = sender.state
        // var stateAsString = sender.stringValue

        if NSOnState == state {
            sender.title = "Uncheck me"
        }
        
        if NSOffState == state {
            sender.title = "Check me"
        }
    }
    
    
    // password action method
    
    @IBAction func passwordChanged(sender: NSTextField) {
        passwordStr = sender.stringValue
        NSLog("passwordChanged(_:): password = \(passwordStr)")
        
        // if the password is revealed, update the clear text
        if revealPassword {
            clearTextField.stringValue = passwordStr
        }
    }
    
    
    // revealButton action method
    
    @IBAction func revealButtonPressed(sender: NSButton) {
        revealPassword = !revealPassword
        NSLog("revealButtonPressed(_:): revealPassword = \(revealPassword)")
        
        if revealPassword
        {
            clearTextField.stringValue = passwordStr
            clearTextField.hidden = false
            sender.title = "Hide"
        }
        else
        {
            clearTextField.stringValue = ""
            clearTextField.hidden = true
            sender.title = "Reveal"
        }
    
        
    }
    
    
}
