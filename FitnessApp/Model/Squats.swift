//
//  Squats.swift
//  FitnessApp
//
//  Created by Syimyk on 1/17/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import Foundation
import RealmSwift

class Squats: Object  {
    @objc dynamic var weekNumber : Int = 0
    @objc dynamic var numberOfRepeat  : Int = 0
    @objc dynamic var date : Date = Date()
    @objc dynamic var totalSquats : Int = 0
}

