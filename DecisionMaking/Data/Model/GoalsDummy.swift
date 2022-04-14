//
//  Goals.swift
//  PuzzleKu
//
//  Created by Rasyid Ridla on 04/04/22.
//

import Foundation

struct GoalsDummy: Identifiable {
    internal init(id: Int, titleGoals: String, textGoals: String, lastUpdate: Date, isPin: Bool, optionList: [GoalOptions]) {
        self.id = id
        self.titleGoals = titleGoals
        self.textGoals = textGoals
        self.lastUpdate = lastUpdate
        self.isPin = isPin
        self.optionList = optionList
    }
    
    let id: Int
    let titleGoals: String
    let textGoals: String
    let lastUpdate: Date
    let isPin: Bool
    let optionList: [GoalOptions]
}

struct GoalOptions: Identifiable {
    internal init(id: Int, titleOption: String, textOption: [String]) {
        self.id = id
        self.titleOption = titleOption
        self.textOption = textOption
    }
    
    let id: Int
    let titleOption: String
    let textOption: [String]
}
