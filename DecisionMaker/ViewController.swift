//
//  ViewController.swift
//  DecisionMaker
//
//  Created by JAS on 6/19/16.
//  Copyright © 2016 decisionmakerproject. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var option1: UITextField!
    @IBOutlet var option2: UITextField!
    @IBOutlet var option3: UITextField!
    @IBOutlet var option4: UITextField!
    @IBOutlet var option5: UITextField!
    
    //@IBOutlet var answer: UITextField!
    
    @IBOutlet var popupAnswerImage: UIImageView!
    @IBOutlet var popupAnswer: UILabel!
    
    //@IBOutlet var decide: decideButton!
    @IBOutlet var decide: decideButton!
    
    
    @IBOutlet var hideKeyboardHintText: UILabel!
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var overlay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overlay.backgroundColor = UIColor(white: 1, alpha: 0)
        self.spinner.alpha = 0.0
        self.spinner.stopAnimating()
        self.popupAnswer.alpha = 0.0
        self.popupAnswerImage.alpha = 0.0

        /* Itapped outside of fields & button remove keyboard */
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        if UIDevice.current.userInterfaceIdiom == .pad {
            self.hideKeyboardHintText.alpha = 0.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* On button press */
    @IBAction func decide(_ sender: Any) {
        self.overlay.backgroundColor = UIColor(white: 1, alpha: 0.6)
        self.spinner.alpha = 1.0
        self.spinner.startAnimating()

        play("hmm")

        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.setTimeout(_:)), userInfo: nil, repeats: false)
    }

    /*  */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /* Function to dismiss keyboard */
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
        self.popupAnswer.alpha = 0.0
        self.popupAnswerImage.alpha = 0.0
        self.overlay.backgroundColor = UIColor(white: 1, alpha: 0.0)
    }
    
    /* Brief pause for "Hmm" sound effect and then random choice selector executes */
    @objc func setTimeout(_ timer : Timer) {
        self.spinner.alpha = 0.0
        self.spinner.stopAnimating()
        
        self.popupAnswer.alpha = 1.0
        self.popupAnswerImage.alpha = 1.0
        
       // play("cheer")
        
        parseOptions()
    }

    /* Easy audio player setup/function */
    var audioPlayer = AVAudioPlayer()
    func play(_ sound: String){
        let audioPathString = Bundle.main.path(forResource: sound, ofType: "mp3")
        if let audioPathString = audioPathString {
            let audioPathURL = URL(fileURLWithPath: audioPathString)
            do{
                try audioPlayer = AVAudioPlayer(contentsOf: audioPathURL)
                audioPlayer.volume = 0.65
                audioPlayer.play()
            }catch{
                print("Sound Error")
            }
        }
    }

    @IBAction func fieldUpdate(_ sender: Any) {
        var pos = 0
        var optionsArray = [String]()
        optionsArray = [self.option1.text!,self.option2.text!,self.option3.text!,self.option4.text!,self.option5.text!]
        var blankChecker = [String]()
        var txt = ""
        
        for i in 0...optionsArray.count-1 {
            if optionsArray[i] != "" {
                txt = optionsArray[i]
                blankChecker.append("")
                blankChecker[pos] = txt
                pos += 1
            }
        }
        
        if pos != 0{
            decide.activateButton(title: "DECIDE")
        } else {
            decide.activateButton(title: "FLIP COIN")
        }
    }
    
    func parseOptions() {
        var pos = 0
        var optionsArray = [String]()
        optionsArray = [self.option1.text!,self.option2.text!,self.option3.text!,self.option4.text!,self.option5.text!]
        var blankChecker = [String]()
        var txt = ""
        
        for i in 0...optionsArray.count-1 {
            if optionsArray[i] != "" {
                txt = optionsArray[i]
                blankChecker.append("")
                blankChecker[pos] = txt
                pos += 1
            }
        }
        if pos != 0 {
            let r = Int(arc4random_uniform(UInt32(blankChecker.count)))
            //self.answer.text = blankChecker[r]
            self.popupAnswer.text = blankChecker[r].uppercased() + "!"
            play("cheer")
        }else{
            blankChecker.append("Heads!")
            blankChecker.append("Tails!")
            let r = Int(arc4random_uniform(UInt32(blankChecker.count)))
            
            self.popupAnswer.text = blankChecker[r]
            //self.popupAnswer.text = "Seriously?!?!"
            play("coin toss")
        }
    }
}
