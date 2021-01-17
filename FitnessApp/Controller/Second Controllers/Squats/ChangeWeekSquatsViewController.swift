//
//  ChangeWeekSquatsViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 1/17/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift

class ChangeWeekSquatsViewController: UIViewController {

       let realm = try! Realm()
    
    
    let squatsInfoVC = SquatsInfoViewController()
    
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
        tempArray.append(squatsInfoVC.workoutProgramm.weekOne)
        tempArray.append(squatsInfoVC.workoutProgramm.weekTwo)
        tempArray.append(squatsInfoVC.workoutProgramm.weekThree)
        tempArray.append(squatsInfoVC.workoutProgramm.weekFour)
        tempArray.append(squatsInfoVC.workoutProgramm.weekFive)
        return tempArray
    }

}

//MARK: - TableView DataSource Methods

extension ChangeWeekSquatsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WorkoutSets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.SecondViewControllers.Squats.changeWeekCell, for: indexPath)
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
           
           let prevProgressions = realm.objects(Squats.self).filter("date BETWEEN %@", [todayStart, todayEnd])
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
                             let progress = Squats()
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
