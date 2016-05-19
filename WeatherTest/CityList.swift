//
//  CityList.swift
//  WeatherTest
//
//  Created by 唐浪 on 16/5/18.
//  Copyright © 2016年 Fansize. All rights reserved.
//

import UIKit

class CityList: NSObject {
    
    let cityName: String
    let news: String
    
    init(cityName: String, news: String) {
        self.cityName = cityName
        self.news = news
    }
}

struct News {
    var cityName: String
    //var weather: CityList
    var news:String
}
