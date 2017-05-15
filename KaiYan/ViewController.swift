//
//  ViewController.swift
//  KaiYan
//
//  Created by wzxjiang on 2017/5/15.
//  Copyright © 2017年 wzxjiang. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    var backgroundImageView: UIImageView!
    
    var titleLabel: UILabel!

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        self.clipsToBounds = true
        
        backgroundImageView =
            UIImageView(frame: CGRect(x: 0, y: -0.5 * Cell.rowHeight, width: UIScreen.main.bounds.width, height: 2 * Cell.rowHeight))
        backgroundImageView.contentMode = .scaleAspectFill
        
        titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.text = "[标题]"
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titleLabel)
        
        contentView.addConstraints([
             NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0),
             NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0)
            ])
    }
    
    func move() {
        DispatchQueue.global().async {
            
            guard let superView = self.superview else { return }
            
            let offsetY = self.convert(self.bounds, to: self.window).midY - superView.center.y
            
            let offset = (offsetY / superView.frame.size.height) * Cell.rowHeight
            
            let trans = CGAffineTransform(translationX: 0, y: -offset)
            
            DispatchQueue.main.async {
                self.backgroundImageView.transform = trans
            }
        }
    }
    
    class var rowHeight: CGFloat { return 250.0 }
}

class ViewController: UITableViewController {

    let datas = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = Cell.rowHeight
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? Cell else {
            return
        }
        
        cell.backgroundImageView.image = UIImage(named: "\(datas[indexPath.row]).png")
        
        cell.move()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return Cell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.visibleCells.map {
            return $0 as? Cell
        }.forEach {
            $0?.move()
        }
    }
}

