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
    
    var match: Match!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(match)")
        // Do any additional setup after loading the view.
    }

    @IBAction func winPlayer1(_ sender: Any) {
    }
    
    @IBAction func winPlayer2(_ sender: Any) {
    }
}
