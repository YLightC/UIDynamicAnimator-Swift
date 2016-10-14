//
//  ViewController.swift
//  UIDynamicAnimator
//
//  Created by yaosixu on 2016/10/10.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    /**
        UIAttachmentBehavior  吸附固定行为
        UICollisionBehavior       碰撞行为
        UIGravityBehavior          重力行为
        UIPushBehavior             推行为
        UISnapBehavior             将物体钉在一个点上
    
        --------UIDynamicItemBehavior 公共属性
         关于CGVector
         0,0 没有方向
         0,1 竖直向下
         0,-1 竖直向上
         1,0 水平向右
         -1,0 水平向左
     
        **公共属性为要进行动画的物体提供了一些属性，类似于现实生活中物体所具有的属性，如弹性系数、能否旋转等
        **因为这些效果属于ios的物理引擎，顾名思义那么物体要运动必须要受力，所以在实现吸附、碰撞的效果时必须要给物体一个力
            这个力可以是重力（通过 UIGravityBehavior添加，力的方向是可以设定的）或者通过UIPushBehavior给物体一个力。明白了这些
            就会知道为什么在设置碰撞行为后物体为什么不运动， 没有力怎么运动呢？
     
     */
    
    var itemCells : [CommTableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MainViewController"
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.darkGray
        
        configTableViewCells()
        configTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configTableViewCells() {
        let backItemButton = UIBarButtonItem()
        backItemButton.title = ""
        self.navigationItem.backBarButtonItem = backItemButton
        itemCells = [
            CommTableViewCell("吸附行为", imgage: "", cellAction: {
                let vc = AttachViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }),
             CommTableViewCell("碰撞行为", imgage: "", cellAction: {
                let vc = CollisionViewController()
                self.navigationController?.pushViewController(vc, animated: true)
             }),
             CommTableViewCell("重力行为", imgage: "", cellAction: {
                let vc = GravityViewController()
                self.navigationController?.pushViewController(vc, animated: true)
             }),
             CommTableViewCell("推动行为", imgage: "", cellAction: {
                let vc = PushViewController()
                self.navigationController?.pushViewController(vc, animated: true)
             }),
             CommTableViewCell("迅速移动", imgage: "", cellAction: {
                let vc = SnapViewController()
                self.navigationController?.pushViewController(vc, animated: true)
             })
        ]
    }
    
    func configTableView() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if (cell == nil) {
            cell = UITableViewCell()
            cell?.textLabel?.text = itemCells[indexPath.row].title
        }
        
        guard let resultCell = cell else {
            return UITableViewCell()
        }
        
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = itemCells[indexPath.row].action
        action?()
    }
    
}


