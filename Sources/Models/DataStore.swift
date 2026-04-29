import Foundation

// MARK: - DataStore (UserDefaults Persistence)

class DataStore {
    static let shared = DataStore()
    
    private let tasksKey = "dailyiq.tasks"
    private let goalsKey = "dailyiq.goals"
    private let settingsKey = "dailyiq.settings"
    
    private init() {}
    
    // MARK: - Tasks
    
    func saveTasks(_ tasks: [Task]) {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    func loadTasks() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: tasksKey),
              let tasks = try? JSONDecoder().decode([Task].self, from: data) else {
            return []
        }
        return tasks
    }
    
    // MARK: - Goals
    
    func saveGoals(_ goals: [Goal]) {
        if let encoded = try? JSONEncoder().encode(goals) {
            UserDefaults.standard.set(encoded, forKey: goalsKey)
        }
    }
    
    func loadGoals() -> [Goal] {
        guard let data = UserDefaults.standard.data(forKey: goalsKey),
              let goals = try? JSONDecoder().decode([Goal].self, from: data) else {
            return []
        }
        return goals
    }
    
    // MARK: - Settings
    
    func saveSetting<T: Codable>(key: String, value: T) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: "\(settingsKey).\(key)")
        }
    }
    
    func loadSetting<T: Codable>(key: String, defaultValue: T) -> T {
        guard let data = UserDefaults.standard.data(forKey: "\(settingsKey).\(key)"),
              let value = try? JSONDecoder().decode(T.self, from: data) else {
            return defaultValue
        }
        return value
    }
}