//
//  Progression.swift
//  FitnessApp
//
//  Created by Syimyk on 12/5/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import Foundation
import RealmSwift

class Progression: Object  {
    @objc dynamic var weekNumber : Int = 0
    @objc dynamic var numberOfRepeat  : Int = 0
    @objc dynamic var date : String = ""
    @objc dynamic var totalPushUps : Int = 0
}
