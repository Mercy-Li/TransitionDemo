//
//  PresentedViewController.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

class PresentedViewController: UIViewController {
    
    let dismissButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view.
        dismissButton.setTitleColor(.black, for: .normal)
        dismissButton.setTitle("dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(onDismissTapped), for: .touchUpInside)
        view.addSubview(dismissButton)
        dismissButton.alpha = 0
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = dismissButton.widthAnchor.constraint(equalToConstant: 1)
        widthConstraint.identifier = "Width"
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            widthConstraint,
            dismissButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let widthContrainst = dismissButton.constraints.filter { (constraint) -> Bool in
            constraint.identifier == "Width"
        }.first
        widthContrainst?.constant = 50
        
        UIView.animate(withDuration: 0.3) {
            self.dismissButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    
    @objc func onDismissTapped() {
        let widthContrainst = dismissButton.constraints.filter { (constraint) -> Bool in
            constraint.identifier == "Width"
        }.first
        widthContrainst?.constant = 1
        
        
        UIView.animate(withDuration: 0.4, animations: {
            self.dismissButton.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }

}
