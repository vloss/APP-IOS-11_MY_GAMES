//
//  ViewController+CoreData.swift
//  My Games
//
//  Created by Vinicius Loss on 13/02/23.
//

import Foundation
import UIKit
import CoreData

extension UIViewController{
    
    // para recuperar o context que foi criado no CoreData Stack
    var context:NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
