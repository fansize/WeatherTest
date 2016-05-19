//
//  NewViewController.swift
//  WeatherTest
//
//  Created by 唐浪 on 16/5/19.
//  Copyright © 2016年 Fansize. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var branchButton: UIButton!
    @IBOutlet weak var fileButton: UIButton!
    @IBOutlet weak var cafeButton: UIButton!
    @IBOutlet weak var textItem: UITextField!
    
    func resetButton() {
        childButton.selected = false
        branchButton.selected = false
        fileButton.selected = false
        cafeButton.selected = false
    }

    @IBAction func childButton(sender: AnyObject) {
        resetButton()
        childButton.selected = true
    }
    
    @IBAction func branchButton(sender: AnyObject) {
        resetButton()
        branchButton.selected = true
    }
    
    @IBAction func fileButton(sender: AnyObject) {
        resetButton()
        fileButton.selected = true
    }
    
    @IBAction func cafeButton(sender: AnyObject) {
        resetButton()
        cafeButton.selected = true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITextFieldDelegate实现的方法：点击键盘之外的区域，键盘消失
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        textItem.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
