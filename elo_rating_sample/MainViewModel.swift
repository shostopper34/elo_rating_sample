//
//  MainViewModel.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import Foundation
import RealmSwift

final class MainViewModel {
        
    func createNewMatch(size: Int) -> Int {
        let realm: Realm =  try! Realm()
        let match = Match.create(realm: realm)
        try! realm.write {
            realm.add(match)
        }
        return match.id
    }
    
    func createPlayers(matchId: Int, size: Int) {
        let realm: Realm = try! Realm()
        for _ in 0..<size {
            let player = Player.create(realm: realm)
            player.name = "Player #\(player.id)"
            try! realm.write {
                realm.add(player)
            }
        }
        
    }
}
