//
//  AppDelegate.swift
//  FitnessApp
//
//  Created by Syimyk on 12/2/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            _ = try Realm()
        }catch{
            print("error while installing new realm\(error)")
        }
        
        return true
    }

}

