//
//  SquatsInfoViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 1/16/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift


class SquatsInfoViewController: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var infoLabel: UIView!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var totalRepsLabel: UILabel!
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var changeWeekBtn: UIButton!
    
    
    
    
      var workoutProgramm = WorkoutProgramm(weekOne: [8,10,8,8,6], weekTwo: [10,12,10,10,8], weekThree: [10,15,12,12,10], weekFour: [15,15,15,15,12], weekFive: [15,20,18,16,12])
    
    
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
        loadProgress()
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
        loadProgress()
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
    
    //need change----------
    @IBAction func startBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: K.SecondViewControllers.Squats.trainingSegue, sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  K.SecondViewControllers.Squats.trainingSegue{
            let destinationVC = segue.destination as! StartSquatsViewController
            destinationVC.reps = week
            destinationVC.totalSquats = stringTotal()
        }
    }
    
    
    
    
    @IBAction func unwindSegue(_ sender : UIStoryboardSegue){}
    //========
    
    
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
    
    
    //MARK: - Data Manupulation Methods,READ
    
    func loadProgress(){
        let progress = realm.objects(Squats.self)
        if let lastSavedProgress = progress.last{
            weekNum = lastSavedProgress.weekNumber
            numberOfRepeatOfWeek = lastSavedProgress.numberOfRepeat
            
        }
    }
    
    
    

}
