//
//  CityList.swift
//  WeatherTest
//
//  Created by 唐浪 on 16/5/18.
//  Copyright © 2016年 Fansize. All rights reserved.
//

import UIKit

class CityList: NSObject {
    
    var cityName = 0
    var name: String
    let news = "dfs"
    var list = [Int: String]()
    
    
    
    func addTwoInts(a: Int, _ b: Int) -> Int {
        return a + b
    }

    
    //list = [1:"fdf", 2:"fdfd"]
    var cityweather: [String: String] = ["fd":"fsd", "fdd":"fd"]
    
    init(name: String) {
        self.name = name
    }
    
    func add() {
//        print("add方法:")
//        print(list.count)
//        for (aa, ba) in cityweather {
//            print("\(aa):\(ba)")
//        }
        let somePoint = (15, 1)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0):
            print("(\(somePoint.0), 0) is on the x-axis")
        
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        case (_, 2):
            print("(0, \(somePoint.1)) is on the y-axis")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
    }
    
    func cityhaha(aa: String, bb: Int) {
        print(add())
    }
    
    func printMathResult(mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")
    }
    
    

}

struct News {
    var cityName: String
    var weather: CityList
    var news:String
}
