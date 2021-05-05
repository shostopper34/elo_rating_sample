//
//  Player.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import Foundation
import RealmSwift

class Player: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var score: Int = 1500
    @objc dynamic var matchId: Int = 0
    @objc dynamic var matchCount: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func newId(realm: Realm) -> Int {
        if let player = realm.objects(Player.self).sorted(byKeyPath: "id").last {
            return player.id + 1
        }
        return 1
    }
    
    static func create(realm: Realm) -> Player {
        let player = Player()
        player.id = newId(realm: realm)
        return player
    }
}
