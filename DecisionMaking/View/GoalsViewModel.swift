//
//  AddViewViewModel.swift
//  PuzzleKu
//
//  Created by Rasyid Ridla on 08/04/22.
//

import Foundation
import CoreData

class GoalsViewModel: ObservableObject {
    
    @Published var titleGoals : String = ""
    @Published var textGoals : String = ""
    @Published var countOption : Int = 2
    @Published var isPin: Bool = false
    
    //add func
    func addGoal(context : NSManagedObjectContext) {
        let newGoal = Goals(context: context)
        newGoal.titleGoals = titleGoals
        newGoal.textGoals = textGoals
        newGoal.countOption = Int32(countOption)
        newGoal.lastUpdate = Date.now
        newGoal.isPin = false
        
        do{
            try context.save()
            
            titleGoals = ""
            textGoals = ""
            countOption = 2
            isPin = false
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    //pin func
    func pinGoals(goal: Goals, context : NSManagedObjectContext){
        titleGoals = goal.titleGoals!
        textGoals = goal.textGoals!
        countOption = Int(goal.countOption)
        isPin = goal.isPin
        
        
        if goal.isPin {
            let update = Goals(context: context)
            update.titleGoals = titleGoals
            update.textGoals = textGoals
            update.countOption = Int32(countOption)
            update.lastUpdate = Date.now
            update.isPin = false
        }
        else if goal.isPin == false {
            let update = Goals(context: context)
            update.titleGoals = titleGoals
            update.textGoals = textGoals
            update.countOption = Int32(countOption)
            update.lastUpdate = Date.now
            update.isPin = true
        }
        
        context.delete(goal)
        try! context.save()
        titleGoals = ""
        textGoals = ""
        countOption = 2
        isPin = false
    }
    
    //add count
    func addOption(goal: Goals, context : NSManagedObjectContext)  {
            titleGoals = goal.titleGoals!
            textGoals = goal.textGoals!
            countOption = Int(goal.countOption)
            isPin = goal.isPin
            
            
            if goal.isPin {
                let update = Goals(context: context)
                update.titleGoals = titleGoals
                update.textGoals = textGoals
                update.countOption = Int32(countOption)
                update.lastUpdate = Date.now
                update.isPin = false
            }
            else if goal.isPin == false {
                let update = Goals(context: context)
                update.titleGoals = titleGoals
                update.textGoals = textGoals
                update.countOption = Int32(countOption)
                update.lastUpdate = Date.now
                update.isPin = true
            }
            
            context.delete(goal)
            try! context.save()
            titleGoals = ""
            textGoals = ""
            countOption = 0
            isPin = false
    }
}
