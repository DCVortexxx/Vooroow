import Foundation
import SwiftData

// MARK: - Model
@Model
final class GameResult {
    var timestamp: Date
    var difficulty: String
    var score: Int
    var streak: Int

    init(
        timestamp: Date = .now,
        difficulty: String,
        score: Int,
        streak: Int
    ) {
        self.timestamp = timestamp
        self.difficulty = difficulty
        self.score = score
        self.streak = streak
    }

}

// MARK: - Queries
extension GameResult {

    func save(in context: ModelContext) {
        context.insert(self)
    }

    static func history(in context: ModelContext) -> [GameResult] {
        (try? context.fetch(FetchDescriptor<GameResult>.all(by: \.timestamp))) ?? []
    }

    static func bestScore(in context: ModelContext) -> Int {
        (try? context
            .fetch(FetchDescriptor<GameResult>.max(by: \.score))
            .first?
            .score) ?? 0
    }

    static func bestStreak(in context: ModelContext) -> Int {
        (try? context
            .fetch(FetchDescriptor<GameResult>.max(by: \.streak))
            .first?
            .streak) ?? 0
    }

}
