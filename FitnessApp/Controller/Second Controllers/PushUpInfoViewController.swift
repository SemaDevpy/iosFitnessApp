//
//  PushUpInfoViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/2/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class PushUpInfoViewController: UIViewController {
    
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var infoLabel: UIView!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var totalRepsLabel: UILabel!
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var changeWeekBtn: UIButton!
    
    let workoutProgramm = WorkoutProgramm(weekOne: [20,20,15,15,10], weekTwo: [25,25,20,15,10], weekThree: [30,30,25,20,15], weekFour: [35,30,25,20,15], weekFive: [40,35,25,25,15])
    
    
    var weekNum = 0
    
    var numberOfRepeatOfWeek = 0
    
    var week : [Int]{
        switch weekNum {
        case 0:
            return workoutProgramm.weekOne
        case 1:
            return workoutProgramm.weekTwo
        case 2:
            return workoutProgramm.weekThree
        case 3:
            return workoutProgramm.weekFour
        case 4:
            return workoutProgramm.weekFive
        default:
            return workoutProgramm.weekOne
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.applyDesign()
        changeWeekBtn.applyDesign()
        
        infoLabel.layer.cornerRadius = 15
        infoLabel.clipsToBounds = true
        
        progressBar.applyDesign()
        
        setsLabel.text = stringArray()
        totalRepsLabel.text = stringTotal()
        
        progressBar.progress = setProgress()
        
        
        weekLabel.text = "Progress for week \(weekNum + 1)"
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setsLabel.text = stringArray()
        totalRepsLabel.text = stringTotal()
        progressBar.progress = setProgress()
        
        if weekNum <= 4{
            weekLabel.text = "Progress for week \(weekNum + 1)"
        }else{
            weekNum = 0
            weekLabel.text = "Progress for week \(weekNum + 1)"
        }
        
    }
    
    
    @IBAction func startBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: K.trainingSegue, sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StartPushUpViewController
        destinationVC.reps = week
    }
    
    
    
    
    @IBAction func unwindSegue(_ sender : UIStoryboardSegue){}
    
    
    
    
    //MARK: - UI Functions
    func stringArray() -> String{
        var stringArray = ""
        for number in week{
            stringArray.append(" \(String(number))")
        }
        return stringArray
    }
    
    
    func stringTotal() ->String{
        let stringInt = week.reduce(0, +)
        return String(stringInt)
    }
    
    
    
    
    func setProgress() -> Float{
        switch numberOfRepeatOfWeek {
        case 3:
            return 1.0
        case 2:
            return 0.6666
        case 1:
            return 0.3333
        default:
            return 0.0
        }
    }
    
    
}





//MARK: - Extending UIprogressView
extension UIProgressView{
    func applyDesign(){
        self.transform = self.transform.scaledBy(x: 1, y: 10) //giving the height to progress bar
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
