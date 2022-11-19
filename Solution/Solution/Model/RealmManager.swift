//
//  RealmManager.swift
//  Solution
//
//  Created by 정재근 on 2022/11/03.
//

import Foundation
import RealmSwift
import RxSwift

class RealmManager {
    static let realm = try! Realm()
    
    static func getSolution() -> Observable<[Solution]>  {
        return Observable.create { event in
            let solution = RealmManager.realm.objects(Solution.self).map({$0})
            
            if solution.count != 0 {
                event.onNext(solution.reversed())
                event.onCompleted()
            } else {
                event.onError(RealmError.notFoundData)
            }
            return Disposables.create {
                
            }
        }
    }
    
    static func addSolution(in solution: Solution) {
        do {
            try RealmManager.realm.write {
                RealmManager.realm.add(solution)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func deleteSolution(in solution: Solution) {
        do {
            try RealmManager.realm.write {
                RealmManager.realm.delete(solution)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
