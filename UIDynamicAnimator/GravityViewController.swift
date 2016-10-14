//
//  GravityViewController.swift
//  UIDynamicAnimator
//
//  Created by yaosixu on 2016/10/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

/** 重力行为 */

class GravityViewController: UIViewController,UIDynamicAnimatorDelegate  {

    let ball = Ellipse()
    let circile = UIView()
    var animator = UIDynamicAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "重力行为"
        view.backgroundColor = UIColor.darkGray
        // Do any additional setup after loading the view.
        
        ball.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        ball.layer.cornerRadius = min(ball.bounds.size.width / 2, ball.bounds.size.height / 2)
        ball.layer.masksToBounds = true
        ball.backgroundColor = UIColor.blue
        self.view.addSubview(ball)
        
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
        gravity()
    }
    
    func gravity() {
        /*
            注意**： 当只给物体添加一个重力行为时，物体是无限制下落的，尽管我们的屏幕尺寸只有那么大；
            就好比一个物体从一个无限高的地方下落，永远都不会着地，所以下落也就不会结束。
            dynamicAnimatorDidPause这个函数也不会运行.
            所以在这里我给物体加一个碰撞边界
         */
        animator = UIDynamicAnimator(referenceView: self.view)
        animator.delegate = self
        
        let gravityBehavior = UIGravityBehavior(items: [ball])
        gravityBehavior.magnitude = 2
        gravityBehavior.gravityDirection = CGVector(dx: 0, dy: 1)
        gravityBehavior.angle = CGFloat(M_PI_4)
        animator.addBehavior(gravityBehavior)
        
        let colission = UICollisionBehavior(items: [ball])
        colission.translatesReferenceBoundsIntoBoundary = true
        colission.collisionMode = .everything
        animator.addBehavior(colission)
        
        let itemBehavior = UIDynamicItemBehavior(items: [ball])
        itemBehavior.elasticity = 0.4
        animator.addBehavior(itemBehavior)
    }
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        print("\(#function)")
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
        print("\(#function)")
    }
    
}
