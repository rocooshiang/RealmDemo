//
//  Person.swift
//  RealmDemo
//
//  Created by Geosat-RD01 on 2015/11/24.
//  Copyright © 2015年 Geosat-RD01. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var age = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
