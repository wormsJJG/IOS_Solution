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
    static func getSolution(in realm: Realm) -> Observable<[Solution]>  {
        return Observable.create { event in
            let solution = realm.objects(Solution.self).map({$0})
            
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
    
    static func addSolution(in solution: Solution, with realm: Realm){
        do {
            try realm.write {
                realm.add(solution)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
