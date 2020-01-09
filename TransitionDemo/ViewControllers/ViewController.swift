//
//  ViewController.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let transationDelegate = ModalTransitionDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }

    @IBAction func onPushTapped(_ sender: Any) {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    @IBAction func onPresentTapped(_ sender: Any) {
        let toVC = PresentedViewController()
        toVC.transitioningDelegate = transationDelegate
        toVC.modalPresentationStyle = .custom
        present(toVC, animated: true, completion: nil)
    }
    
}

