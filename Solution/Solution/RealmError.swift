//
//  RealmError.swift
//  Solution
//
//  Created by 정재근 on 2022/11/09.
//

import Foundation

enum RealmError: Error, LocalizedError {
    case notFoundData
    
    var localizedError: String {
        switch self {
        case .notFoundData:
            return "Realm에서 데이터를 찾을수 없음"
        }
    }
}
