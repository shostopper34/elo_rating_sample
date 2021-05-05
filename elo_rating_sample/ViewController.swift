//
//  ViewController.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    private func configureView() {
        textField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                self.okButton.isHidden = text.isEmpty
            }).disposed(by: disposeBag)
    }

    @IBAction func tapOkButton(_ sender: Any) {
        let size = Int(textField.text ?? "") ?? 0
        if size > 0 {
            showMatchAlert(size: size)
        } else {
            AlertUtil.showAlert(title: "人数は0以上で入力してください",
                                message: "",
                                parentViewController: self)

        }
    }
    
    private func showMatchAlert(size: Int) {
        let title = "大会を作成"
        let message = "\(size)人で対戦します\nよろしいですか？"
        AlertUtil.showMultiButtonAlert(title: title,
                                       message: message,
                                       positiveButtonTitle: "はい",
                                       negativeButtonTitle: "やり直す",
                                       parentViewController: self,
                                       postiveButtonPushed: {
            self.textField.text = ""
            let match = self.viewModel.createNewMatch(size: size)
            self.viewModel.createPlayers(matchId: match.id, size: size)
            self.performSegue(withIdentifier: "match", sender: match.id)
        }, negativeButtonPushed: {}, completion: {})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "match" {
            let matchViewController = segue.destination as! MatchViewController
            matchViewController.matchId = sender as! Int
        }
    }
}

