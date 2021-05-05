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
    }
}

