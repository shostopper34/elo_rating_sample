//
//  RankingViewController.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import UIKit
import RxRealm
import RealmSwift
import RxSwift
import RxCocoa

class RankingViewController: UITableViewController {

    private var players: Results<Player>!
    private let disposeBag = DisposeBag()

    var matchId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Match #\(matchId) Ranking"
        
        self.tableView.register(UINib(nibName: RankingViewCell.nibName, bundle: nil),
                                forCellReuseIdentifier: RankingViewCell.reuseIdentifier)
        let realm = try! Realm()
        players = realm.objects(Player.self)
            .filter("matchId == \(matchId)")
            .sorted(byKeyPath: "score", ascending: false)
        
        Observable.collection(from: players)
            .map { results in "players: \(results.count)" }
            .subscribe { event in
                print("\(event.element!)")
            }.disposed(by: disposeBag)
        
        Observable.changeset(from: players)
            .subscribe(onNext: { [unowned self] _, changes in
                if let changes = changes {
                    self.tableView.applyChangeset(changes)
                } else {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = players[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RankingViewCell.reuseIdentifier, for: indexPath) as! RankingViewCell
        cell.bind(player: player, rank: indexPath.row + 1)
        return cell
    }
}
