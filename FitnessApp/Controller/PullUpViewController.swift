//
//  PullUpViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/2/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class PullUpViewController: UIViewController {
    
    @IBOutlet weak var statistics: UIButton!
    @IBOutlet weak var train: UIButton!
    @IBOutlet weak var pullUpImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        train.applyDesign()
        statistics.applyDesign()
        
        pullUpImage.layer.cornerRadius = 15
        pullUpImage.clipsToBounds = true
        pullUpImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}

extension UIButton{
    func applyDesign(){
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
