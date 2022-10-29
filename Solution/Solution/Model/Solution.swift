//
//  File.swift
//  Solution
//
//  Created by 정재근 on 2022/10/30.
//

import Foundation
import RealmSwift

class Solution: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var userCount: Int = 0
    @objc dynamic var options: [String] = []
}
