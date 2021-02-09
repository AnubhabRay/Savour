//
//  Invitee.swift
//  Savour
//
//  Created by FNSPL on 26/01/21.
//  Copyright © 2021 FNSPL. All rights reserved.
//

import Foundation
import CoreData

class Invitee : NSManagedObject{
    
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Invitee] {
        let request : NSFetchRequest<Invitee> = Invitee.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "isRibhu", ascending: false)]
        guard let tasks = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return tasks
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
    Invitee.fetchAll(viewContext: viewContext).forEach({ viewContext.delete($0) })
    try? viewContext.save()
    }
   
    
}
