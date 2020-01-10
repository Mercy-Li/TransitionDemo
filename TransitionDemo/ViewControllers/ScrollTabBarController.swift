//
//  ScrollTabBarController.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

class ScrollTabBarController: UITabBarController {
    
    private var panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
    var tabbarVCDelegate: TabControllerDelegate?
    
    private var subViewControllerCount: Int {
        let count = viewControllers?.count ?? 0
        return count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tabBar.tintColor = .green
        panGesture.addTarget(self, action: #selector(handlePan(pan:)))
        view.addGestureRecognizer(panGesture)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func handlePan(pan: UIPanGestureRecognizer) {
        let tranX = panGesture.translation(in: view).x
        let tranAbs = tranX > 0 ? tranX : -tranX
        let progress = tranAbs / view.frame.width
        
        switch panGesture.state {
        case .began:
            tabbarVCDelegate = delegate as? TabControllerDelegate
            tabbarVCDelegate?.interactive = true
            let velocityX = panGesture.velocity(in: view).x
            if velocityX < 0 {
                if selectedIndex < subViewControllerCount - 1 {
                    selectedIndex += 1
                }
            } else {
                if selectedIndex > 0 {
                    selectedIndex -= 1
                }
            }
        case .changed:
            tabbarVCDelegate?.interactionController.update(progress)
        case .cancelled, .ended:
            if progress > 0.3 {
                tabbarVCDelegate?.interactionController.completionSpeed = 0.99
                tabbarVCDelegate?.interactionController.finish()
            } else {
                tabbarVCDelegate?.interactionController.completionSpeed = 0.99
                tabbarVCDelegate?.interactionController.cancel()
            }
            tabbarVCDelegate?.interactive = false
            
        default: break
        }
        
    }

}
