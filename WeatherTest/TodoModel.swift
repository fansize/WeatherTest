//
//  TodoModel.swift
//  WeatherTest
//
//  Created by 唐浪 on 16/5/18.
//  Copyright © 2016年 Fansize. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    
    var id: String
    var image: String
    var text: String
    var date: NSDate
    
    init(id: String, image: String, text: String, date: NSDate) {
        self.id = id
        self.image = image
        self.text = text
        self.date = date
    }

}
