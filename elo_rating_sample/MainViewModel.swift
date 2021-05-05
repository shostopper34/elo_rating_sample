//
//  MainViewModel.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import Foundation
import RealmSwift

final class MainViewModel {
    
    func createNewMatch(size: Int) {
        let realm: Realm =  try! Realm()
        let match = Match.create(realm: realm)
        try! realm.write {
            realm.add(match)
        }
    }
    
    func createPlayers(matchId: Int, size: Int) {
        let realm: Realm = try! Realm()
        var players: [Player] = []
        for _ in 0..<size {
            let player = Player.create(realm: realm)
            player.name = "Player #\(player.id)"
            players.append(player)
        }
        try! realm.write {
            realm.add(players)
        }
    }
}
