// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let player = try? JSONDecoder().decode(Player.self, from: jsonData)

import Foundation

// MARK: - Player

struct Player: Codable {
    let playerInfo: PlayerInfo
}

// MARK: - PlayerInfo

struct PlayerInfo: Codable {
    let name, height, weight, title: String
    let level, exp: Int
    let expToNextLevel: Int
    let lastOpenApps: String
    let stats: Stats
    let today: Today
    let completedTasks: [Task]
    let boost: Boost
}

// MARK: - Boost

struct Boost: Codable {
    let streak: Int
    let doubleExp: Bool
}

// MARK: - Task

struct Task: Codable {
    let id, name: String
    let qty: Int
    let unit: String
    let isDone: Bool?
}

// MARK: - Stats

struct Stats: Codable {
    let str, int, soc, foc: Int
    let luc: Int

    enum CodingKeys: String, CodingKey {
        case str = "STR"
        case int = "INT"
        case soc = "SOC"
        case foc = "FOC"
        case luc = "LUC"
    }
}

// MARK: - Today

struct Today: Codable {
    let tasks: [Task]
    let completeTask, percentage: Int
    let challenges: Challenges
}

// MARK: - Challenges

struct Challenges: Codable {
    let drinkWater: DrinkWater
}

// MARK: - DrinkWater

struct DrinkWater: Codable {
    let times: Int
    let unit: String
    let isDone: Bool
    let exp, streak: Int
}
