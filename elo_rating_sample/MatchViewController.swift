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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(matchId)")
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Match #\(matchId)"
    }

    @IBAction func winPlayer1(_ sender: Any) {
    }
    
    @IBAction func winPlayer2(_ sender: Any) {
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
