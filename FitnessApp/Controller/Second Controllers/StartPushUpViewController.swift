//
//  StartPushUpViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/3/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class StartPushUpViewController: UIViewController {

    var reps : [Int] = []
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var repsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        repsLabel.text = stringArray()
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = btn.frame.width/2
        btn.backgroundColor = .gray
    }
    

    func stringArray() -> String{
        var list = ""
        for num in reps{
            list.append(" \(num)")
        }
        return list
    }

}
