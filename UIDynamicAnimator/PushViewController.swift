//
//  PushViewController.swift
//  UIDynamicAnimator
//
//  Created by yaosixu on 2016/10/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

/**  推动行为 */

class PushViewController: UIViewController {
    
    let ball = Ellipse()
    let circile = UIView()
    var animator = UIDynamicAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "推动行为"
        view.backgroundColor = UIColor.darkGray
        
        ball.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        ball.layer.cornerRadius = min(ball.bounds.size.width / 2, ball.bounds.size.height / 2)
        ball.layer.masksToBounds = true
        ball.backgroundColor = UIColor.blue
        self.view.addSubview(ball)
        // Do any additional setup after loading the view.
        circile.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        circile.backgroundColor = UIColor.black
        circile.layer.cornerRadius = min(circile.bounds.size.width / 2, circile.bounds.size.height / 2)
        circile.layer.masksToBounds = true
        ball.addSubview(circile)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        push()
    }
    
    func push() {
        animator = UIDynamicAnimator(referenceView: self.view)
        
        //推力在之前已经做过介绍，可以看碰撞行为的代码
        let pushBehavior = UIPushBehavior(items: [ball], mode: .continuous)
        pushBehavior.active = true
        pushBehavior.magnitude = 1
        pushBehavior.pushDirection = CGVector(dx: 0, dy: 1)
        animator.addBehavior(pushBehavior)
        
        let colission = UICollisionBehavior(items: [ball])
        colission.translatesReferenceBoundsIntoBoundary = true
        colission.collisionMode = .everything
        animator.addBehavior(colission)
        
        let itemBehavior = UIDynamicItemBehavior(items: [ball])
        itemBehavior.elasticity = 0.4
        itemBehavior.addAngularVelocity(-3, for: itemBehavior.items.first!)
        animator.addBehavior(itemBehavior)
    }
    
}
