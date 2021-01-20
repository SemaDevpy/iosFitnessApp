//
//  SquatsViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/2/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class SquatsViewController: UIViewController {

    @IBOutlet weak var squatsImage: UIImageView!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        squatsImage.applyDesignForImage()
        trainButton.applyDesign()
        statisticsButton.applyDesign()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }


}
//MARK: - Extending buttons functionality
extension UIButton{
    func applyDesign(){
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

extension UIImageView{
    func applyDesignForImage(){
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
