//
//  CollisionViewController.swift
//  UIDynamicAnimator
//
//  Created by yaosixu on 2016/10/12.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

/** 碰撞行为 */

class CollisionViewController: UIViewController {

    var attachButton = UIButton()
    var newButton = UIButton()
    var animationer = UIDynamicAnimator()
    let ball = Ellipse(frame: CGRect(x: 150, y: 100, width: 50, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "碰撞行为"
        view.backgroundColor = UIColor.darkGray
        attachButton = UIButton(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        attachButton.backgroundColor = UIColor.blue
        view.addSubview(attachButton)
        
        
        newButton = UIButton(frame: CGRect(x: 160, y: 100, width: 50, height: 50))
        newButton.backgroundColor = UIColor.red
        self.view.addSubview(newButton)
        // Do any additional setup after loading the view.
        
//        ball.backgroundColor = UIColor.red
//        ball.layer.cornerRadius = ball.bounds.size.height / 2
//        ball.layer.masksToBounds = true
//        self.view.addSubview(ball)
//        
//        let point = UIView(frame: CGRect(x: 20, y: 20, width: 10, height: 10))
//        point.backgroundColor = UIColor.black
//        ball.addSubview(point)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collisionAnimation()
        
//        slideBounds()
    }
    
//    func slideBounds() {
//        animationer = UIDynamicAnimator(referenceView: self.view)
//        let gBehavior = UIGravityBehavior(items: [ball])
//        gBehavior.gravityDirection = CGVector(dx: 0, dy: 1)
//        animationer.addBehavior(gBehavior)
//        
//        let colission = UICollisionBehavior(items: [ball])
//        colission.collisionMode = .everything
//        let identifier = "identifier"
//        colission.addBoundary(withIdentifier: identifier as NSCopying, from: CGPoint(x:100, y:300), to: CGPoint(x: 300, y: 400))
//        colission.translatesReferenceBoundsIntoBoundary = true
//        animationer.addBehavior(colission)
//    }
    
    fileprivate func collisionAnimation() {
        animationer = UIDynamicAnimator(referenceView: self.view)
        
        //给物体一个力，这个力可以是重力，也可以是通过UIPushBehavior自定义的一个推力
        
        let gBehavior = UIGravityBehavior(items: [attachButton])
        gBehavior.gravityDirection = CGVector(dx: 0, dy: 1)
        animationer.addBehavior(gBehavior)
        
        /*
            在这要注意一个问题，物体做自由落体运动受到的力是重力（忽略空气阻力），这个力是连续的，
            所以在这自定义推力的时候要把力的模式设置为连续的，否则会出现一些奇葩的景象，就好比物体是在一个没有力的环境中一样
         */
        
//        //设置一个推力，受力的对象是attacButton,力的模式是连续的
//        let pushBehavior = UIPushBehavior(items: [attachButton], mode: .continuous)
//        //设置推力为活动状态
//        pushBehavior.active = true
//        //设置推力的方向为竖直向下
//        pushBehavior.pushDirection = CGVector(dx: 0, dy: 1)
//        //设置力的大小
//        pushBehavior.magnitude = 2
//        animationer.addBehavior(pushBehavior)
        
//        let rotaionPushBehavior = UIPushBehavior(items: [attachButton], mode: .instantaneous)
//        rotaionPushBehavior.active = true
//        rotaionPushBehavior.pushDirection = CGVector(dx: 0.5, dy: 0.5)
//        rotaionPushBehavior.magnitude = 0.5
//        animationer.addBehavior(rotaionPushBehavior)
        
        /*
            前面提到的 --------UIDynamicItemBehavior 公共属性，可以给要处理的对象加上一些物理属性
            在这个例子中要处理的对象是attachButton，下面给出一些示例。要看出加上这些物理属性的区
            别可以打开下面代码
         */
        
        let itemBehavior = UIDynamicItemBehavior(items: [attachButton])
        
        //物体的弹性系数，从小到大，默认值是0，效果就像从高处扔下一块泥巴
        itemBehavior.elasticity = 0.5
        //摩擦力默认值为0
//        itemBehavior.friction = 0
        //密度
//        itemBehavior.density = 1
        /*
         线性方向的阻力取值范围为0 ---CGFloat_MAX 默认值为0, 在自由落体运动（本例中，可以看为空气阻力）
         当这个值设置的非常大的时候可以看到本例中的物体没有下落。。。。
         */
//        itemBehavior.resistance = 10
        
        
        //这两个属性的理解来源于 http://www.cocoachina.com/ios/20150719/12613.html（英文原版 http://fancypixel.github.io/blog/2015/06/19/playing-with-uidynamics-in-ios-9/）
        //(iOS 9.0, *)
        //代表能够影响一个元素在电磁场上如何移动的电荷（是的，听起来很疯狂）
//        itemBehavior.charge = 100
        //anchored本质上是将图形变成了碰撞中的一个静态物体，但没有响应事件（如果有什么东西撞上了它，它会丝毫不动），所以可以完美地用来表示地板或墙壁。
//        itemBehavior.isAnchored = true
        
        
        
        //角阻力，物体旋转时的阻力
//        itemBehavior.angularResistance = 0
        //是否允许物体旋转
//        itemBehavior.allowsRotation = true
        animationer.addBehavior(itemBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [attachButton])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .everything
        
        /*
        //让物体旋转
         let identifier = "liner"
         let liner = UIView(frame: CGRect(x: 100, y: 300, width:20, height: 3))
         liner.backgroundColor = UIColor.red
         view.addSubview(liner)
         collisionBehavior.addBoundary(withIdentifier: identifier as NSCopying, from: CGPoint(x:100, y:300), to: CGPoint(x: 120, y: 300))
         
         */
        animationer.addBehavior(collisionBehavior)
    }
    
}


class Ellipse: UIView {
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}

