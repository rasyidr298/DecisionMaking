//
//  HomeViewModel.swift
//  PuzzleKu
//
//  Created by Rasyid Ridla on 05/04/22.
//

import CoreData
import Foundation

class HomeViewModel: ObservableObject {
    
    func pinGoals(goal: Goals, context : NSManagedObjectContext){
        if  goal.isPin {
            goal.isPin = false
        }
        else if goal.isPin == false {
            goal.isPin = true
        }
        try! context.save()
    }
    
}
