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
        let exp = pow(10, -((oldScore - opponentOldScore) / E))
        print("win oldscore = \(oldScore) opponentoldscore = \(opponentOldScore)")
        return Int(oldScore + (K * (Score.win.rawValue - (1.0 / (1.0 + exp)))))
    }
    
    static func lose(oldScore: Double, opponentOldScore: Double) -> Int {
        let exp = pow(10, -((oldScore - opponentOldScore) / E))
        return Int(oldScore + (K * (Score.lose.rawValue - (1.0 / (1.0 + exp)))))
    }
}

enum Score: Double {
    case win = 1
    case lose = 0
}
