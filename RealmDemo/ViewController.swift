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
        
        Realm1()
        
        //一對多的情況
        Realm2()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func Realm1(){
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
        
        //刪除全部
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func Realm2(){
        let realm = try! Realm()
        
        //刪除全部
        try! realm.write{
            realm.deleteAll()
        }
        
        let taskListA = TaskList()
        taskListA.name = "WishList"
        
        //#1 實體化在塞參數
        let wish1 = Task()
        wish1.name = "iPhone 7"
        wish1.notes = "64GB,Gold"
        
        //#2 Dictionary
        let wish2 = Task(value: ["name":"iPhone 6","notes":"32GB,Silver"])
        
        //#3 Array，需按照index順序
        let wish3 = Task(value: ["iPhone 6", NSDate(), "16GB,Gold", false])
        
        taskListA.tasks.appendContentsOf([wish1,wish2,wish3])
        
        //Nested Objects
        let taskListB = TaskList(value: ["MoviesList", NSDate(), [["The Martian", NSDate(), "", false], ["The Maze Runner", NSDate(), "", true]]])
        
        //新增
        try! realm.write {
            realm.add([taskListA,taskListB])
        }

        //查詢
        let lists = realm.objects(TaskList)
        for idx in 0..<lists.count{
            let list = lists[idx]
            print("查詢：")
            print(list.name)
            
        }
        
        //排序查詢
        let lists2 = realm.objects(Task).sorted("name")
        for idx in 0..<lists2.count{
            let list = lists2[idx]
            print("排序查詢：")
            print(list.name)
        }
        
        //過濾查詢 using NSPredicate
        let predicate = NSPredicate(format: "name = %@ AND notes = %@", "iPhone 6", "32GB,Silver")
        let phone = realm.objects(Task).filter(predicate)
        for idx in 0..<phone.count{
            let list = phone[idx]
            print("過濾查詢：")
            print(list.name)
        }
        
        //單一刪除
        try! realm.write({ () -> Void in
            realm.delete(lists2[1])
        })
        

    }
    
}

