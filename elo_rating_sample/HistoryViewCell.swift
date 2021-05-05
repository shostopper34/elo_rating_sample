//
//  HistoryViewCell.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import UIKit

class HistoryViewCell: UITableViewCell {

    static let nibName: String = "HistoryViewCell"
    static let reuseIdentifer: String = "HistoryViewCell"
    
    @IBOutlet weak var matchLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.matchLabel.text = ""
    }
    
    func bind(match: Match) {
        self.matchLabel.text = "Match #\(match.id)"
    }
    
}
