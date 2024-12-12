//
//  Extensions.swift
//  FlashChat
//
//  Created by Yuunan kin on 2024/12/13.
//
import UIKit

extension UIViewController {
    func showToast(message: String, duration: Double = 4.0) {

        let toastLabel = UILabel(
            frame: CGRect(
                x: self.view.frame.size.width/2 - 150,
                y: self.view.frame.size.height-100,
                width: 300,
                height: 50
            )
        )
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)

        UIView
            .animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
