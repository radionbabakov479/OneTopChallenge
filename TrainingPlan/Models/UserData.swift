import Foundation
import SwiftUI

class UserData: ObservableObject {
    @Published var selectedCategories: [TaskCategory] = []
    @Published var dailyTasks: [DailyTask] = []
    @Published var selectedTaskIndex: Int?
    @Published var taskHistory: [DailyTask] = []
    @Published var diaryEntries: [DiaryEntry] = []
    
    private let selectedCategoriesKey = "selectedCategories"
    private let dailyTasksKey = "dailyTasks"
    private let selectedTaskIndexKey = "selectedTaskIndex"
    private let taskHistoryKey = "taskHistory"
    private let diaryEntriesKey = "diaryEntries"
    private let currentStreakKey = "currentStreak"
    private let bestStreakKey = "bestStreak"
    
    private var currentStreak: Int = 0
    private var bestStreak: Int = 0
    
    init() {
        loadData()
        checkAndResetDailyTasks()
    }
        
    func saveSelectedCategories(_ categories: [TaskCategory]) {
        selectedCategories = categories
        saveData()
    }
    
    func createNewDailyTasks() {
        let categories = selectedCategories.isEmpty ? Array(TaskCategory.allCases) : selectedCategories
        
        dailyTasks = []
        for i in 0..<3 {
            let categoryIndex = i % categories.count
            let category = categories[categoryIndex]
            let task = TaskService.getRandomTask(for: category)
            dailyTasks.append(task)
        }
        
        selectedTaskIndex = nil
        saveData()
    }
    
    func selectTask(index: Int) {
        guard index < dailyTasks.count else { return }
        
        if dailyTasks[index].status == .completed || dailyTasks[index].isCompleate {
            selectedTaskIndex = index
            return
        }
        
        selectedTaskIndex = index
        var updatedTask = dailyTasks[index]
        updatedTask.status = .select
        dailyTasks[index] = updatedTask
        
        saveData()
    }
    
    func markTaskAsCompleted() {
        guard let index = selectedTaskIndex, index < dailyTasks.count else { return }
        
        var task = dailyTasks[index]
        task.status = .completed
        task.isCompleate = true
        dailyTasks[index] = task
        
        let historyTask = DailyTask(
            id: UUID(),
            category: task.category,
            text: task.text,
            status: task.status,
            date: task.date,
            isCompleate: task.isCompleate
        )
        taskHistory.append(historyTask)
        selectedTaskIndex = nil
        updateStreaks(taskCompleted: true)
        saveData()
    }
    
    func markTaskAsNotCompleted() {
        guard let index = selectedTaskIndex, index < dailyTasks.count else { return }
        
        var task = dailyTasks[index]
        task.status = .didNotComplete
        task.isCompleate = false
        dailyTasks[index] = task
        
        let historyTask = DailyTask(
            id: UUID(),
            category: task.category,
            text: task.text,
            status: task.status,
            date: task.date,
            isCompleate: task.isCompleate
        )
        taskHistory.append(historyTask)
        selectedTaskIndex = nil
        updateStreaks(taskCompleted: false)
        saveData()
    }
    
    var allTasksCompleted: Bool {
        return dailyTasks.count == 3 && dailyTasks.allSatisfy { $0.status == .completed }
    }
    
    func addDiaryEntry(_ entry: DiaryEntry) {
        diaryEntries.append(entry)
        saveData()
    }
    
    func getCompletedTasksCount() -> Int {
        return taskHistory.filter { $0.isCompleate }.count
    }
    
    func getNotCompletedTasksCount() -> Int {
        return taskHistory.filter { !$0.isCompleate }.count
    }
    
    func getCurrentStreak() -> Int {
        return currentStreak
    }
    
    func getBestStreak() -> Int {
        return bestStreak
    }
    
    func getTasksCompletedByType(_ category: TaskCategory) -> Int {
        return taskHistory.filter { $0.category == category && $0.isCompleate }.count
    }
    
    func getJournalEntriesCount() -> Int {
        return diaryEntries.count
    }
    
    private func updateStreaks(taskCompleted: Bool) {
        if taskCompleted {
            currentStreak += 1
            if currentStreak > bestStreak {
                bestStreak = currentStreak
            }
        } else {
            currentStreak = 0
        }
        
        UserDefaults.standard.set(currentStreak, forKey: currentStreakKey)
        UserDefaults.standard.set(bestStreak, forKey: bestStreakKey)
    }
    
    func resetAllData() {
        selectedCategories = []
        dailyTasks = []
        selectedTaskIndex = nil
        taskHistory = []
        diaryEntries = []
        currentStreak = 0
        bestStreak = 0
        
        UserDefaults.standard.removeObject(forKey: selectedCategoriesKey)
        UserDefaults.standard.removeObject(forKey: dailyTasksKey)
        UserDefaults.standard.removeObject(forKey: selectedTaskIndexKey)
        UserDefaults.standard.removeObject(forKey: taskHistoryKey)
        UserDefaults.standard.removeObject(forKey: diaryEntriesKey)
        UserDefaults.standard.removeObject(forKey: currentStreakKey)
        UserDefaults.standard.removeObject(forKey: bestStreakKey)
        
        createNewDailyTasks()
    }
    
    private func checkAndResetDailyTasks() {
        if dailyTasks.isEmpty {
            createNewDailyTasks()
            return
        }
        
        let firstTaskDate = dailyTasks[0].date
        if !Calendar.current.isDateInToday(firstTaskDate) {
            for task in dailyTasks where task.status != .completed {
                var updatedTask = task
                updatedTask.status = .completed
                updatedTask.isCompleate = false
                
                let historyTask = DailyTask(
                    id: UUID(),
                    category: updatedTask.category,
                    text: updatedTask.text,
                    status: updatedTask.status,
                    date: updatedTask.date,
                    isCompleate: updatedTask.isCompleate
                )
                taskHistory.append(historyTask)
            }
            
            if !dailyTasks.contains(where: { $0.isCompleate }) {
                currentStreak = 0
                UserDefaults.standard.set(currentStreak, forKey: currentStreakKey)
            }
            
            createNewDailyTasks()
        }
    }
    
    private func saveData() {
        let encoder = JSONEncoder()
        
        if let encodedCategories = try? encoder.encode(selectedCategories) {
            UserDefaults.standard.set(encodedCategories, forKey: selectedCategoriesKey)
        }
        
        if let encodedTasks = try? encoder.encode(dailyTasks) {
            UserDefaults.standard.set(encodedTasks, forKey: dailyTasksKey)
        }
        
        if let encodedHistory = try? encoder.encode(taskHistory) {
            UserDefaults.standard.set(encodedHistory, forKey: taskHistoryKey)
        }
        
        if let encodedEntries = try? encoder.encode(diaryEntries) {
            UserDefaults.standard.set(encodedEntries, forKey: diaryEntriesKey)
        }
        
        UserDefaults.standard.set(selectedTaskIndex, forKey: selectedTaskIndexKey)
    }
    
    private func loadData() {
        let decoder = JSONDecoder()
        
        if let savedCategories = UserDefaults.standard.data(forKey: selectedCategoriesKey),
           let decodedCategories = try? decoder.decode([TaskCategory].self, from: savedCategories) {
            selectedCategories = decodedCategories
        }
        
        if let savedTasks = UserDefaults.standard.data(forKey: dailyTasksKey),
           let decodedTasks = try? decoder.decode([DailyTask].self, from: savedTasks) {
            dailyTasks = decodedTasks
        }
        
        if let savedHistory = UserDefaults.standard.data(forKey: taskHistoryKey),
           let decodedHistory = try? decoder.decode([DailyTask].self, from: savedHistory) {
            taskHistory = decodedHistory
        }
        
        if let savedEntries = UserDefaults.standard.data(forKey: diaryEntriesKey),
           let decodedEntries = try? decoder.decode([DiaryEntry].self, from: savedEntries) {
            diaryEntries = decodedEntries
        }
        
        selectedTaskIndex = UserDefaults.standard.object(forKey: selectedTaskIndexKey) as? Int
        currentStreak = UserDefaults.standard.integer(forKey: currentStreakKey)
        bestStreak = UserDefaults.standard.integer(forKey: bestStreakKey)
    }
}
