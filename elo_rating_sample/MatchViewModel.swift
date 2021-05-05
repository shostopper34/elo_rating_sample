//
//  MatchViewModel.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift
import RxCocoa

final class MatchViewModel {
    
    private(set) var players: Results<Player>!
    
    private(set) var matches: [(Player, Player)] = []
    
    func players(matchId: Int) {
        let realm = try! Realm()
        players = realm.objects(Player.self)
            .filter("matchId == \(matchId)")
            .sorted(byKeyPath: "matchCount", ascending: true)
        let comb = roundRobin(n: players.count)
        let playerArray = players.toArray()
        for match in comb {
            matches.append((playerArray[match.0], playerArray[match.1]))
        }
    }
    
    // 次の対戦
    func getCurrentMatch() -> (Player, Player)? {
        return matches.first
    }
    
    // おわったらリストから消していく
    func removeMatch() {
        if matches.first != nil {
            matches.remove(at: 0)
        }
    }
    
    func updateScore(player: Player, score: Int) {
        let realm = try! Realm()

        try! realm.write {
            player.score = score
            player.matchCount += player.matchCount
            realm.add(player, update: .modified)
        }
    }
    
    func roundRobin(n: Int) -> [(Int, Int)] {
        var match: [(Int, Int)] = []
        var M: [Int] = []
        for i in 0..<n {
            M.append(i)
        }
        let center = Int(n / 2)
        if n % 2 == 0 {
            for _ in 0..<(n - 1) {
                for j in 0..<center {
                    match.append((M[0+j], M[M.count - 1 - j]))
                }
                let first = M[0]
                let second = M[1]
                let els = M[2...M.count - 1]
                M = []
                M.append(first)
                els.forEach { M.append($0) }
                M.append(second)
            }
            print(match)
        } else {
            for _ in 0..<n {
                for j in 1..<(center + 1) {
                    if j == 1 {
                        match.append((M[j], M[0]))
                    } else {
                        match.append((M[j], M[M.count - j + 1]))
                    }
                }
                let first = M[0]
                let els = M[1...M.count - 1]
                M = []
                els.forEach { M.append($0) }
                M.append(first)
            }
            print(match)
        }
        return match
    }
}
