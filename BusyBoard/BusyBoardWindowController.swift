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
    @IBOutlet weak var alphaTextField: NSTextField!
    
    
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
    
    // color well variables
    var initialColorWellColor = NSColor.blackColor()
    
    override var windowNibName: String? {
        return "BusyBoardWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        // tell the shared color panel to show alpha (default is to not show alpha)
        NSColorPanel.sharedColorPanel().showsAlpha = true
        
        self.saveInitialControlSettings()
        
        
        // initialize UI
        
        // initialize slider variables
        oldSliderValue = slider.doubleValue
        self.adjustSliderValue(slider)              // initializes slider status text field
        
        // radio buttion selection
        self.radioGroupChanged(radioGroup)          // conforms slider tick display to radio buttons unpacked from nib
        
        
        // initialize password variables
        passwordStr = passwordTextField.stringValue
        // revealPassword = false                   // initialized above to false - no need to init it again
        
        // update color component output from color well
        self.colorWellChanged(colorWell)
        
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
        
        // color well
        initialColorWellColor = colorWell.color
        
        
        
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
        passwordStr = initialPasswordString
        clearTextField.stringValue = initialPasswordString
        
        // we set revealPassword to the opposite of initialRevealPassword - the action 
        // method will negate revealPassword
        revealPassword = !initialRevealPassword
        self.revealButtonPressed(revealButton)
        
        // check box
        checkBox.state = initialCheckBoxState
        self.checkBoxChanged(checkBox)
        
        // color well
        colorWell.color = initialColorWellColor
        self.colorWellChanged(colorWell)
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
        // NSLog("radioGroupChanged(_:)")
        
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
        // NSLog("passwordChanged(_:): password = \(passwordStr)")
        
        // if the password is revealed, update the clear text
        if revealPassword {
            clearTextField.stringValue = passwordStr
        }
    }
    
    
    // revealButton action method
    
    @IBAction func revealButtonPressed(sender: NSButton) {
        revealPassword = !revealPassword
        // NSLog("revealButtonPressed(_:): revealPassword = \(revealPassword)")
        
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
    
    
    // colorwell action function
    
    @IBAction func colorWellChanged(sender: NSColorWell) {
        var red:        CGFloat = 0
        var green:      CGFloat = 0
        var blue:      CGFloat = 0
        var alpha:      CGFloat = 0
        
        var color: NSColor!
        
        color = sender.color
        
        // color is in an unknown colorspace - attempting to extract RGBA components could raise an exception
        var colorSpace = NSColorSpace.genericRGBColorSpace
        color = color.colorUsingColorSpace(colorSpace())
        if color != nil
        {
            // we successfully converted color to color within RGB colorspace
            
            color.getRed(&red,
                green: &green,
                blue: &blue,
                alpha: &alpha)
            
            var componentStr = "red = \(red)"
            redTextField.stringValue = componentStr
            
            componentStr = "green = \(green)"
            greenTextField.stringValue = componentStr
            
            componentStr = "blue = \(blue)"
            blueTextField.stringValue = componentStr
            
            componentStr = "alpha = \(alpha)"
            alphaTextField.stringValue = componentStr
        }
        else
        {
            // unable to convert to color within RGB color space
            var componentStr = "red = n/a"
            redTextField.stringValue = componentStr
            
            componentStr = "green = n/a"
            greenTextField.stringValue = componentStr
            
            componentStr = "blue = n/a"
            blueTextField.stringValue = componentStr
            
            componentStr = "alpha = n/a"
            alphaTextField.stringValue = componentStr
        }
    }
}
