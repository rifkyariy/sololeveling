//
//  Helper.swift
//  Solo Leveling
//
//  Created by Rifky Ari on 25/02/24.
//

import Foundation

// model basic info

enum Helper {
    static func getBasicInfo() -> (String?, String?, String?) {
        let name = UserDefaults.standard.string(forKey: "name")
        let height = UserDefaults.standard.string(forKey: "height")
        let weight = UserDefaults.standard.string(forKey: "weight")

        // return tuple
        return (name, height, weight)
    }

    static func checkIfBasicInfoIsExist() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: "name") {
            return true
        }
        return false
    }

    static func decodeJSONString() -> Player? {
        if let data = UserDefaults.standard.data(forKey: "playerInfo") {
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(Player.self, from: data)
                return result
            } catch {
                print("Error: \(error)")
            }
        }
        return nil
    }

    static func encodeJSONString(player: Player) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(player)
            UserDefaults.standard.set(data, forKey: "playerInfo")
        } catch {
            print("Error: \(error)")
        }
    }

    static func generateFirstTimeData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let name = UserDefaults.standard.string(forKey: "name") ?? ""
        let height = UserDefaults.standard.string(forKey: "height") ?? "0"
        let weight = UserDefaults.standard.string(forKey: "weight") ?? "0"
        let lastOpenApps = dateFormatter.string(from: Date())

        let stats = Stats(str: 1, int: 1, soc: 1, foc: 1, luc: 0)

        let today = Today(
            tasks: [],
            completeTask: 0,
            percentage: 0,
            challenges: Challenges(
                drinkWater: DrinkWater(
                    times: 0,
                    unit: "glasses",
                    isDone: false,
                    exp: 1,
                    streak: 1
                )
            )
        )

        let boost = Boost(streak: 0, doubleExp: false)

        // string to int
        let heightInt = Int(height) ?? 0

        let playerInfo = PlayerInfo(name: name, height: height, weight: weight, title: "Nothing", level: 1, exp: 0, expToNextLevel: 0, lastOpenApps: lastOpenApps, stats: stats, today: today, completedTasks: [], boost: boost)

        let player = Player(playerInfo: playerInfo)

        // store to user default
        encodeJSONString(player: player)
    }
}
