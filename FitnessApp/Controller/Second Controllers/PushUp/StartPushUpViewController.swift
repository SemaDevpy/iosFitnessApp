//
//  StartPushUpViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/3/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift

class StartPushUpViewController: UIViewController {
    
    let realm = try! Realm()
    
    var countDown = 2
    var timer = Timer()
    
    var reps = [Int]()
    
    var totalPushUpsPerDay = ""
    
    var numberOfReps = 0
    var numTracker = 0
    
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var completedBtn: UIButton!
    
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
        statusLbl.isHidden = true
        if numberOfReps >= 2{
            numberOfReps = numberOfReps - 1
            btn.setTitle("\(numberOfReps)", for: .normal)
        }else{
            if numTracker < 4{
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDownMethod), userInfo: nil, repeats: true)
                numTracker += 1
                numberOfReps = reps[numTracker]
                currentLabel.text = "Current: \(numberOfReps)"
            }else{
                statusLbl.isHidden = false
                btn.setTitle("!", for: .normal)
                statusLbl.text = "Workout is complete"
                completedBtn.isHidden = false
                doneBtn.isEnabled = false
            }
        }
    }
    
    
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        statusLbl.isHidden = true
        if numTracker < 4{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDownMethod), userInfo: nil, repeats: true)
            numTracker += 1
            numberOfReps = reps[numTracker]
            currentLabel.text = "Current: \(numberOfReps)"
        }else{
            statusLbl.isHidden = false
            btn.setTitle("!", for: .normal)
            statusLbl.text = "Workout is complete"
            completedBtn.isHidden = false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desinationVC = segue.destination as! PushUpInfoViewController
        
        if desinationVC.numberOfRepeatOfWeek <= 1{
            desinationVC.numberOfRepeatOfWeek += 1
        }else{
            if desinationVC.weekNum <= 3{
                desinationVC.weekNum += 1
                desinationVC.numberOfRepeatOfWeek = 0
            }else{
                desinationVC.weekNum = 0
                desinationVC.numberOfRepeatOfWeek = 0
            }
            
        }
        
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.timeZone = .current
//        formatter.locale = .current
//        formatter.dateFormat = "MM/dd/yyyy"
//        let dateString = formatter.string(from: date)
        
        
        //MARK: - Creating new progress or Updating current,CREATE and UPDATE
        //for one day there should be only one note
        let todayStart = Calendar.current.startOfDay(for: Date())
        let todayEnd: Date = {
          let components = DateComponents(day: 1, second: -1)
          return Calendar.current.date(byAdding: components, to: todayStart)!
        }()
        
        let prevProgressions = realm.objects(Progression.self).filter("date BETWEEN %@", [todayStart, todayEnd])
        if !prevProgressions.isEmpty{
            do{
                try realm.write{
                    prevProgressions[0].weekNumber = desinationVC.weekNum
                    prevProgressions[0].numberOfRepeat = desinationVC.numberOfRepeatOfWeek
                    prevProgressions[0].totalPushUps =  prevProgressions[0].totalPushUps + Int(totalPushUpsPerDay)!
                }
            }catch{
                print("error in updating\(error)")
            }
        }else{
            let progress = Progression()
            progress.numberOfRepeat = desinationVC.numberOfRepeatOfWeek
            progress.weekNumber = desinationVC.weekNum
            progress.totalPushUps = Int(totalPushUpsPerDay)!
            saveProgress(progress: progress)
        }
    }
    
    
    
    
    //MARK: - Supporting Functionality
    @objc func countDownMethod(){
        statusLbl.isHidden = false
        statusLbl.text = "Rest"
        if countDown != 0{
            countDown -= 1
            btn.setTitle("\(countDown)", for: .normal)
            btn.isEnabled = false
            doneBtn.isEnabled = false
        }else{
            timer.invalidate()
            statusLbl.isHidden = true
            btn.setTitle("\(numberOfReps)", for: .normal)
            countDown = 2
            btn.isEnabled = true
            doneBtn.isEnabled = true
        }
        
        
    }
    
    
    
    //MARK: - UI code
    func stringArray() -> String{
        var list = ""
        for num in reps{
            list.append(" \(num)")
        }
        return list
    }

//MARK: -  - Data Manupulation Methods

func saveProgress(progress : Progression){
        do{
            try realm.write{
                realm.add(progress)
            }
        }catch{
             print("error in adding progress\(error)")
        }
}
    
//    func deletePrevProgress(){
//        let prevProgress = realm.objects(Progression.self)
//        do{
//            try realm.write{
//                realm.delete(prevProgress)
//            }
//        }catch{
//            print("error in deleting prev progress")
//        }
//    }
    
    
}
