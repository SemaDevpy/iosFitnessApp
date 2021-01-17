//
//  ChangeWeekViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 1/15/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift

class ChangeWeekViewController: UIViewController {

    let realm = try! Realm()
    
    
    let pushUpInfoVC = PushUpInfoViewController()
    
    @IBOutlet weak var tableView: UITableView!
    
    var WorkoutSets : [[Int]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Week"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        WorkoutSets = fillAnArray()
    }
    
    
    
    func fillAnArray() -> [[Int]]{
        var tempArray = [[Int]]()
        tempArray.append(pushUpInfoVC.workoutProgramm.weekOne)
        tempArray.append(pushUpInfoVC.workoutProgramm.weekTwo)
        tempArray.append(pushUpInfoVC.workoutProgramm.weekThree)
        tempArray.append(pushUpInfoVC.workoutProgramm.weekFour)
        tempArray.append(pushUpInfoVC.workoutProgramm.weekFive)
        return tempArray
    }
    
    
}


//MARK: - TableView DataSource Methods

extension ChangeWeekViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkoutSets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.SecondViewControllers.PushUps.changeWeekCell, for: indexPath)
        cell.textLabel?.text = "Week \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "\(WorkoutSets[indexPath.row])"
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todayStart = Calendar.current.startOfDay(for: Date())
           let todayEnd: Date = {
             let components = DateComponents(day: 1, second: -1)
             return Calendar.current.date(byAdding: components, to: todayStart)!
           }()
           
           let prevProgressions = realm.objects(PushUps.self).filter("date BETWEEN %@", [todayStart, todayEnd])
           if !prevProgressions.isEmpty{
               do{
                   try realm.write{
                    prevProgressions[0].weekNumber = indexPath.row
                       prevProgressions[0].numberOfRepeat = 0
                   }
               }catch{
                   print("error in updating\(error)")
               }
           }else{
                 do {
                         try realm.write{
                             let progress = PushUps()
                             progress.numberOfRepeat = 0
                             progress.weekNumber = indexPath.row
                             realm.add(progress)
                         }
                     } catch  {
                         print("error in saving new progress \(error.localizedDescription)")
                     }
            
           }        
        navigationController?.popViewController(animated: true)
    }
}
