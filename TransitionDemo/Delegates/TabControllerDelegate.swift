//
//  TabControllerDelegate.swift
//  TransitionDemo
//
//  Created by 李潇 on 2020/1/9.
//  Copyright © 2020 liao. All rights reserved.
//

import UIKit

class TabControllerDelegate: NSObject, UITabBarControllerDelegate {
    var interactive = false
    let interactionController = UIPercentDrivenInteractiveTransition()
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let fromIndex = tabBarController.viewControllers!.firstIndex(of: fromVC)!
        let toIndex = tabBarController.viewControllers!.firstIndex(of: toVC)!
        
        let tabChangeDirection: TabOperationDirection = toIndex < fromIndex ? .left : .right
        let transitionType = TransitionType.tabbar(tabChangeDirection)
        let slideAnmiationController = SlideAnimatorController(type: transitionType)
        return slideAnmiationController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? interactionController : nil
    }
}
