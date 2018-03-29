//
//  ViewController.swift
//  BullsEye
//
//  Created by Usuario on 28/03/2018.
//  Copyright © 2018 Usuario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentSliderValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var rounds = 0
    @IBOutlet weak var roundsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentSliderValue = lroundf(slider.value)
        resetGame()
        
        let thumbnailImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbnailImageNormal, for: .normal)
        
        let thumbnailImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbnailImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundsLabel.text = String(rounds)
    }
    func startNewRound() {
        rounds += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentSliderValue = 50
        slider.value = Float(currentSliderValue)
        updateLabels()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("the current value of slider is \(slider.value)")
        currentSliderValue = lroundf(slider.value)
    }

    @IBAction func showAlert() {
        let difference = abs(currentSliderValue - targetValue)
        var points = 100 - difference
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 20 {
            title = "Pretty close..."
        } else {
            title = "Not even close..."
        }
        score += points
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func resetGame() {
        score = 0
        rounds = 0
        startNewRound()
    }
}

