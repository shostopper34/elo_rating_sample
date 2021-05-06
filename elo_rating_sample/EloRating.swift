//
//  EloRating.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import Foundation

class EloRating {
    
    static let K: Double = 32.0
    static let E: Double = 400.0
    
    static func win(oldScore: Double, opponentOldScore: Double) -> Int {
        return Int(oldScore + Double((K * Score.win.rawValue - (1.0 / (1.0 + pow(10, -((oldScore - opponentOldScore) / E)))))))
    }
    
    static func lose(oldScore: Double, opponentOldScore: Double) -> Int {
        return Int(oldScore + Double((K * Score.lose.rawValue - (1.0 / (1.0 + pow(10, -((oldScore - opponentOldScore) / E)))))))
    }
}

enum Score: Double {
    case win = 1
    case lose = 0
}
