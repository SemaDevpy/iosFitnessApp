//
//  StartPushUpViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/3/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class StartPushUpViewController: UIViewController {
    
    var timer : Timer!

    var reps = [Int]()
    
    var listIncrementer = 0
    var numberOfReps = 0
    var numTracker = 0
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repsLabel.text = stringArray()
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = btn.frame.width/2
        btn.backgroundColor = .gray
        
        numberOfReps = reps[numTracker]
        currentLabel.text = "Current: \(numberOfReps)"
        btn.setTitle("\(numberOfReps)", for: .normal)

    }
    

    @IBAction func btnTapped(_ sender: UIButton) {
        if numberOfReps != 0{
            btn.setTitle("\(numberOfReps - 1)", for: .normal)
            numberOfReps = numberOfReps - 1
        }else{
            if numTracker < 4{
                numTracker += 1
                numberOfReps = reps[numTracker]
                currentLabel.text = "Current: \(numberOfReps)"
                btn.setTitle("\(numberOfReps)", for: .normal)
            }
        }
    }
    
    
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        numberOfReps = 0
        btn.setTitle("\(numberOfReps)", for: .normal)
    }
    
    
    
    //MARK: - Supporting Functionality

    
    
    
    //MARK: - UI code
    func stringArray() -> String{
           var list = ""
           for num in reps{
               list.append(" \(num)")
           }
           return list
       }
}
