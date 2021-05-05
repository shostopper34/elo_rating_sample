//
//  HistoryViewController.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import UIKit
import RxRealm
import RealmSwift
import RxSwift
import RxCocoa

class HistoryViewController: UITableViewController {

    private var matches: Results<Match>!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Match履歴"
        
        self.tableView.register(UINib(nibName: HistoryViewCell.nibName, bundle: nil),
                                forCellReuseIdentifier: HistoryViewCell.reuseIdentifer)
        
        let realm = try! Realm()
        matches = realm.objects(Match.self).sorted(byKeyPath: "id", ascending: false)
        
        Observable.collection(from: matches)
            .map { results in "matches: \(results.count)" }
            .subscribe { event in
                print("\(event.element!)")
            }.disposed(by: disposeBag)
        
        Observable.changeset(from: matches)
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
        return matches.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let match = matches[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryViewCell.reuseIdentifer, for: indexPath) as! HistoryViewCell
        cell.bind(match: match)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Observable.from(object: matches[indexPath.row])
            .subscribe(onNext: { [weak self] match in
                self?.performSegue(withIdentifier: "match", sender: match.id)
            }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "match" {
            let matchViewController = segue.destination as! MatchViewController
            matchViewController.matchId = sender as! Int
        }
    }

}

extension UITableView {
    func applyChangeset(_ changes: RealmChangeset) {
        beginUpdates()
        deleteRows(at: changes.deleted.map { IndexPath(row: $0, section: 0)}, with: .automatic)
        insertRows(at: changes.inserted.map { IndexPath(row: $0, section: 0)}, with: .automatic)
        reloadRows(at: changes.updated.map { IndexPath(row: $0, section: 0)}, with: .automatic)
        endUpdates()
    }
}
