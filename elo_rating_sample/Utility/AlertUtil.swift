//
//  File.swift
//  elo_rating_sample
//
//  Created by Sho Yasuda on 2021/05/05.
//

import UIKit

enum AlertUtil {
    
    /// 複数ボタンアラート
    static func showMultiButtonAlert(title: String,
                                     message: String,
                                     positiveButtonTitle: String? = nil,
                                     negativeButtonTitle: String? = nil,
                                     parentViewController: UIViewController,
                                     postiveButtonPushed: (() -> Void)? = nil,
                                     negativeButtonPushed: (() -> Void)? = nil,
                                     completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let actionPositive = UIAlertAction(title: positiveButtonTitle ?? "OK",
                                           style: UIAlertAction.Style.default,
                                           handler: { (action: UIAlertAction) in
            postiveButtonPushed?()
        })
        let actionNegative = UIAlertAction(title: negativeButtonTitle ?? "Cancel",
                                           style: UIAlertAction.Style.default,
                                           handler: { (action: UIAlertAction) in
            negativeButtonPushed?()
        })
        alert.addAction(actionPositive)
        alert.addAction(actionNegative)
        
        parentViewController.present(alert, animated: true, completion: {
            completion?()
        })
    }
    
    static func showAlert(title: String,
                          message: String,
                          buttonTitle: String? = nil,
                          parentViewController: UIViewController,
                          buttonDidPushed: (() -> Void)? = nil,
                          completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let action1 = UIAlertAction(title: buttonTitle ?? "OK",
                                    style: UIAlertAction.Style.default,
                                    handler: { (action: UIAlertAction) in
            buttonDidPushed?()
        })
        alert.addAction(action1)
        parentViewController.present(alert, animated: true, completion: {
            completion?()
        })
    }
}
