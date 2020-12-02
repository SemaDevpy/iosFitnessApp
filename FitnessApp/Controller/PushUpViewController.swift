//
//  PushUpViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/2/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class PushUpViewController: UIViewController {

    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    @IBOutlet weak var pushupsImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        trainButton.applyDesign()
        statisticsButton.applyDesign()
        pushupsImage.applyDesignForImage()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
