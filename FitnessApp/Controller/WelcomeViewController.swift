//
//  WelcomeViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/2/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var exercises : [Exercise] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercises = createArray()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Select Workout"
        tableView.separatorStyle = .none
    }
    
    
    func createArray() -> [Exercise]{
        var tempList : [Exercise] = []
        
        let exercise1 = Exercise(image: #imageLiteral(resourceName: "PullUps"), title: "Pull Ups")
        let exercise2 = Exercise(image: #imageLiteral(resourceName: "PushUps"), title: "Push Ups")
        let exercise3 = Exercise(image: #imageLiteral(resourceName: "Dips"), title: "Dips")
        let exercise4 = Exercise(image: #imageLiteral(resourceName: "Squats"), title: "Squats")
        
        tempList.append(exercise1)
        tempList.append(exercise2)
        tempList.append(exercise3)
        tempList.append(exercise4)
        return tempList
    }
}

extension WelcomeViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let exercise = exercises[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.exerciseCell) as! MyTableViewCell
        cell.myImage.image = exercise.image
        cell.myLable.text = exercise.title
        return cell
    }
}
