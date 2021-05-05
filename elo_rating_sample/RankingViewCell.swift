//
//  RankingViewCell.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import UIKit

class RankingViewCell: UITableViewCell {

    static let nibName: String = "RankingViewCell"
    static let reuseIdentifier: String = "RankingViewCell"
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.rankLabel.text = ""
        self.nameLabel.text = ""
        self.pointLabel.text = ""
    }
    
    func bind(player: Player, rank: Int) {
        self.rankLabel.text = "\(rank)"
        self.nameLabel.text = player.name
        self.pointLabel.text = "\(player.score)pt"
    }
    
}
