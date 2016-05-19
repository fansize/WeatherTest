//
//  CityListViewController.swift
//  WeatherTest
//
//  Created by 唐浪 on 16/5/19.
//  Copyright © 2016年 Fansize. All rights reserved.
//

import UIKit

var citys: [CityList] = []
var cityStrs: [News] = []

class CityListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        citys = [CityList(cityName: "London", news: "happy"), CityList(cityName: "Beijing", news: "bad"), CityList(cityName: "Shanghai", news: "bad"), CityList(cityName: "Wuhan", news: "bad")]
        
        cityStrs = [News(cityName: "Hongkong", news: "happy"), News(cityName: "Fujian", news: "bad"), News(cityName: "Nanjing", news: "bad"), News(cityName: "Shenzhen", news: "bad")]
        
        //添加navbar左侧按钮
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    /*viewDidLoad()在controller只能载入一次，而viewDidDisappear()则可多次载入，从字面意思也可理解
    override func viewDidDisappear(animated: Bool) {
     
    }
     */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citys.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.cityTableView.dequeueReusableCellWithIdentifier("cell1")! as UITableViewCell
        let city = citys[indexPath.row] as CityList
        let cityStr = cityStrs[indexPath.row]  as News
        let name = cell.viewWithTag(101) as! UILabel
        name.text = cityStr.cityName
        return cell
    }
    
    //实现cell删除从UITableViewDelegate继承的方法
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            citys.removeAtIndex(indexPath.row)
            //直接重新刷新tableview使用reload()就可以了，不过过度很生硬
            //self.tabelView.reloadData()
            self.cityTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    //激活编辑模式(Edit Mode)
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.cityTableView.setEditing(editing, animated: animated)
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
