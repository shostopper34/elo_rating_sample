//
//  MatchViewController.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import UIKit

class MatchViewController: UIViewController {

    @IBOutlet weak var player1: UIButton!
    @IBOutlet weak var player2: UIButton!
    
    var matchId: Int = 0
    
    private var viewModel = MatchViewModel()
    
    var p1: Player?
    var p2: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(matchId)")
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Match #\(matchId)"
        
        viewModel.players(matchId: matchId)
        
        getNextMatch()
    }

    private func updateMatch(p1: Player, p2: Player) {
        player1.setTitle(p1.name, for: .normal)
        player2.setTitle(p2.name, for: .normal)
    }
    
    @IBAction func winPlayer1(_ sender: Any) {
        guard let p1 = self.p1, let p2 = self.p2 else { return }
        let p1Score = EloRating.win(oldScore: Double(p1.score), opponentOldScore: Double(p2.score))
        let p2Score = EloRating.lose(oldScore: Double(p2.score), opponentOldScore: Double(p1.score))
        viewModel.updateScore(player: p1, score: p1Score)
        viewModel.updateScore(player: p2, score: p2Score)
        viewModel.removeMatch()
        
        getNextMatch()
    }
    
    @IBAction func winPlayer2(_ sender: Any) {
        guard let p1 = self.p1, let p2 = self.p2 else { return }
        let p2Score = EloRating.win(oldScore: Double(p2.score), opponentOldScore: Double(p1.score))
        let p1Score = EloRating.lose(oldScore: Double(p1.score), opponentOldScore: Double(p2.score))
        viewModel.updateScore(player: p1, score: p1Score)
        viewModel.updateScore(player: p2, score: p2Score)
        viewModel.removeMatch()
        
        getNextMatch()
    }
    
    private func getNextMatch() {
        guard let match = viewModel.getCurrentMatch() else {
            self.showAgainAlert()
            return
        }
        self.p1 = match.0
        self.p2 = match.1
        updateMatch(p1: match.0, p2: match.1)
    }
    
    private func showAgainAlert() {
        AlertUtil.showMultiButtonAlert(title: "対戦を続けますか？", message: "", positiveButtonTitle: "はい", negativeButtonTitle: "いいえ", parentViewController: self, postiveButtonPushed: {
            self.viewModel.players(matchId: self.matchId)
            self.getNextMatch()
        }, negativeButtonPushed: {
            (self.parent as? UINavigationController)?.popViewController(animated: true)
        }, completion: {})
    }
    
    @IBAction func ranking(_ sender: Any) {
        self.performSegue(withIdentifier: "rank", sender: matchId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rank" {
            let rankViewController = segue.destination as! RankingViewController
            rankViewController.matchId = matchId
        }
    }
}
