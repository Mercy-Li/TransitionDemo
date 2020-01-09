//
//  ViewController.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }

    @IBAction func onPushTapped(_ sender: Any) {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
}

