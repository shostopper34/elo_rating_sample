//
//  EloRating.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import Foundation

class EloRating {
    
    static let K: Int = 32
    static let E: Int = 400
    
    static func win(oldScore: Int, opponentOldScore: Int) -> Int {
        return oldScore + K * (Score.win.rawValue - (1 / (1 + 10 ^ (-(oldScore - opponentOldScore) / E))))
    }
    
    static func lose(oldScore: Int, opponentOldScore: Int) -> Int {
        return oldScore + K * (Score.lose.rawValue - (1 / (1 + 10 ^ (-(oldScore - opponentOldScore) / E))))
    }
}

enum Score: Int {
    case win = 1
    case lose = 0
}
