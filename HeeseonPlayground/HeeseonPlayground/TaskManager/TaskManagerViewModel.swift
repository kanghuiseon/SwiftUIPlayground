//
//  TaskManagerViewModel.swift
//  HeeseonPlayground
//
//  Created by 강희선 on 2022/05/12.
//

import SwiftUI
import CoreData

class TaskManagerViewModel: ObservableObject {
    // MARK: - published
    @Published var currentTab: Tab = .today
    @Published var taskColor: String = "Yellow"
    @Published var taskTitle: String = ""
    @Published var openEditTask: Bool = false
    
    // MARK: - datas
    let colors: [String] = ["Yellow", "Green", "Blue", "Purple", "Red", "Orange"]
    
    // MARK: - core data
    func addTask(_ context: NSManagedObjectContext) -> Bool {
        let task = Task(context: context)
        task.title = taskTitle
        task.color = taskColor
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
    func resetTask() {
        taskTitle = ""
        taskColor = ""
    }
}

extension TaskManagerViewModel {
    enum Tab: String, CaseIterable {
        case today = "Today"
        case upcomiing = "Upcoming"
        case done = "Done"
    }
}
