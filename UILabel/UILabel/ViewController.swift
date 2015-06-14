//
//  ViewController.swift
//  UILabel
//
//  Created by Dee on 15/6/14.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        let label = UILabel(frame: CGRectMake(10, 30, 300, 100))
        
        
        label.text = "<today is a good day and it is sunny>"
        
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
//        label.shadowColor =  UIColor.orangeColor()
        label.shadowOffset = CGSizeMake(-5, 5)
        label.textAlignment = NSTextAlignment.Center
        label.tintColor = UIColor.blackColor()
        label.textColor = UIColor.greenColor()
        label.font = UIFont(name: "Zapfino", size: 20)
        self.view .addSubview(label)
//        label.adjustsFontSizeToFitWidth = true
        
//        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        
        let btn2 :UIButton = UIButton.new()
        
        self.view .addSubview(btn2)
        
        let btn:UIButton = UIButton(frame: CGRectMake(10, 160, 300, 100))
        btn.titleLabel?.text = "DEE"
        
        btn.backgroundColor = UIColor.purpleColor()
        
        btn.addTarget(self, action:Selector("back"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        
    }
    func back()
    {
        print("------")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

