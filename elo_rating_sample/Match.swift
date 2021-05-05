//
//  Tournament.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import Foundation
import RealmSwift

class Match: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var playerCount: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func newId(realm: Realm) -> Int {
        if let match = realm.objects(Match.self).sorted(byKeyPath: "id").last {
            return match.id + 1
        } else {
            return 1
        }
    }
    
    static func create(realm: Realm) -> Match {
        let match = Match()
        match.id = newId(realm: realm)
        return match
    }
}
