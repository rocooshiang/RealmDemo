//
//  ViewController.swift
//  RealmDemo
//
//  Created by Geosat-RD01 on 2015/11/24.
//  Copyright © 2015年 Geosat-RD01. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        
        let rocoo = ["id":0,"name":"rocoo","age":25]
        let rose = ["id":1,"name":"rose","age":27]
        let rodman = ["id":2,"name":"rodman","age":41]        
        
        //新增
        //修改 1.
        try! realm.write{
            realm.create(Person.self, value: rocoo, update: true)
            realm.create(Person.self, value: rose, update: true)
            realm.create(Person.self, value: rodman, update: true)
        }
        
        //修改 2.
        try! realm.write{
            realm.create(Person.self, value: ["id":0,"age":26], update: true)
        }
        
        //查詢 1.
        let obj = realm.objects(Person)
        if obj.count > 0 {
            let idArray = obj.valueForKey("id")
            let nameArray = obj.valueForKey("name")
            let ageArray = obj.valueForKey("age")
            print("查詢1")
            for idx in 0..<obj.count{
                print("id: \(idArray!.objectAtIndex(idx)), name: \(nameArray!.objectAtIndex(idx)), age: \(ageArray!.objectAtIndex(idx))\n")
            }
        }
        
        //查詢 2.
        let obj2 = realm.objects(Person).filter("age < 30")
        if obj2.count > 0 {
            let idArray = obj2.valueForKey("id")
            let nameArray = obj2.valueForKey("name")
            let ageArray = obj2.valueForKey("age")
            
            print("查詢2")
            for idx in 0..<obj2.count{
                print("id: \(idArray!.objectAtIndex(idx)), name: \(nameArray!.objectAtIndex(idx)), age: \(ageArray!.objectAtIndex(idx))\n")
            }
        }
        
        //刪除
        try! realm.write{
            realm.deleteAll()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

