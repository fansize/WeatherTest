//
//  ViewController.swift
//  WeatherTest
//
//  Created by 唐浪 on 16/5/15.
//  Copyright © 2016年 Fansize. All rights reserved.
//

import UIKit
import CoreLocation

var todos: [TodoModel] = []

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource {

    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var didian: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var wendu: UILabel!
   
    //显示tableview需要：1、绑定tableview到controller 2、继承UITableViewDataSource协议 3、绑定tableview到datasource
    @IBOutlet weak var tabelView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.locationManager = [[CLLocationManager alloc] init]
        locationManager.delegate = self  //将位置的delegate传入主循环
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //位置信息调用更精准
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()  //很关键的一句，有了它才提示是否允许设备定位，之前一直无法拉起位置服务；原因暂未知
        todos = [TodoModel(id: "1", image: "cloudy1_night.png", text: "1、去游乐场", date:    dateFromString("2016-11-21")!),
                 TodoModel(id: "1", image: "cloudy1.png", text: "1、去玩", date: dateFromString("2016-11-21")!),
                 TodoModel(id: "1", image: "cloudy2_night.png", text: "1、去打电话", date: dateFromString("2016-11-21")!),
                 TodoModel(id: "1", image: "cloudy2.png", text: "1、去游泳", date: dateFromString("2016-11-21")!)]
        
        print(todos)
    }
    
    
    //继承UITableViewDataSource协议必须实现的两个方法
    //dequeueReusableCellWithIdentifier("35")，使用可重用的cell，其中参数str为重用cell的id，在storyboard中查看即可
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //**返回到cell列数必须要与创建内容库应该有的列数一致，否则报错 PS：理解上应该是可能会有空行
        return todos.count;
    }
    
    
    //cell里内容的更新主要就在这个方法里完成，应该是每新创建一个cell就会回调一次这个方法
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tabelView.dequeueReusableCellWithIdentifier("cell1")! as UITableViewCell
        //print(todos.count)
        let todo = todos[indexPath.row] as TodoModel
        
        let city = cell.viewWithTag(101) as! UILabel
        let image = cell.viewWithTag(102) as! UIImageView
        city.text = todo.text
        image.image = UIImage(named: todo.image)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dateFromString(dateStr: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        let date = formatter.dateFromString(dateStr)
        return date
    }
    
    //当获取位置信息时，CLLocationManagerDelegate调用的回调函数
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocation = locations[locations.count-1]
        if (location.horizontalAccuracy>0) {
            
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            
            updateWeatherInfo(location.coordinate.latitude, longitude:location.coordinate.longitude)
            
            locationManager.stopUpdatingLocation()
        }
        
    }
 
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("获取不到位置信息")
    }
    
    func updateWeatherInfo(latitude:CLLocationDegrees, longitude:CLLocationDegrees) {
        
        let manager = AFHTTPSessionManager()  //AFNetworiking 3.0的新用法，使用AFHTTPSessionManager
        
        let url = "http://api.openweathermap.org/data/2.5/weather?"
        //新的openweathermap.com的api调用除了传入参数还要求传入用户的APIKEY
        
        let params = ["lat":latitude, "lon":longitude, "APPID":"cc2adc1945cb76a89ce82219011f2472"]
 
        
        
        // 定义请求成功和失败的闭包
        let success = { (dataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
            
            //print("JSON" + responseObject!.description)
            self.updateUI(responseObject as! NSDictionary)
        }
        
        let failure = { (dataTask: NSURLSessionDataTask?, error: NSError) -> Void in
           
            print("Error" + error.localizedDescription)
        }
        
        //这个GET方法真是烦，写法好复杂，半天弄不懂
        //主要时success和failure写不对，应该是参数类型不匹配。。。。
        manager.GET(url, parameters: params, success: success, failure: failure)
    }
    
    
    //获取API取得的JSON里的数据并作处理，最后更新到View上
    func updateUI (jsonResult:NSDictionary) {
        
        if let temp = jsonResult["main"]?["temp"] as? Double {
            
            var temp1: Double
            if(jsonResult["sys"]?["country"] as! String == "US") {
                temp1 = round(((temp-273.15)*1.8) + 32)
            }
            else {
                temp1 = round(temp-273.15)
            }
            self.wendu.text = "\(temp1)" + " ℃"
        }
        else {
            print("天气数据为空")
        }
        
        let cityName = jsonResult["name"] as! String
        self.didian.text = cityName
        
        var condition = (jsonResult["weather"] as! NSArray)[0]["id"] as! Int
        var sunrise = jsonResult["sys"]?["sunrise"] as! Double
        var sunset = jsonResult["sys"]?["sunset"] as! Double

        var nightTime = false
        var now = NSDate().timeIntervalSince1970
        if(now<sunrise || now>sunset) {
            nightTime = true
            self.updateIcon(condition, nightTime: nightTime)
            print("Light")
        }
        else {
            self.updateIcon(condition, nightTime: nightTime)
            print("night")
        }
        
    }
    
    func updateIcon(condition: Int, nightTime: Bool) {
        
        print(condition)
        if(condition<300) {
            if nightTime {
                self.icon.image = UIImage(named: "shower2_night")
            }
            else {
                self.icon.image = UIImage(named: "light_rain")
            }
        }
        else if(condition<500){
            self.icon.image = UIImage(named: "cloudy5")
        }
        else if(condition<700){
            self.icon.image = UIImage(named: "cloudy2")
        }
        else {
            self.icon.image = UIImage(named: "tstorm1_night")
        }
    }
    
    //加了测试按钮，一些没写对的功能先用按钮的替代
    
    @IBAction func button(sender: AnyObject) {
        
        print("地址改变")
        //tabelviewcell.text = "Hello"
        //locationManager.startUpdatingLocation()
        //var cl = CityList(name: "NewYork")
        //cl.init("New York")
      
    }

//    @IBOutlet weak var tabel: UITableViewCell!
//    @IBOutlet weak var tabelview: UIView!
//    @IBOutlet weak var tabelviewcell: UILabel!
    
}

