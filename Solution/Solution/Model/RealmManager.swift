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
    
    static func getSolutionList() -> Observable<[Solution]>  {
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
    
    static func deleteOption(in solution: Solution, with index: Int) {
        do {
            try RealmManager.realm.write {
                solution.options.remove(at: index)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getSolution(title: String) -> Observable<Solution> {
        return Observable.create { event in
            let solution = RealmManager.realm.objects(Solution.self).filter { $0.title == title }
            
            if let sol = solution.first {
                event.onNext(sol)
                event.onCompleted()
            } else {
                event.onError(RealmError.notFoundData)
            }
            return Disposables.create {
                
            }
        }
    }
    
    static func updateSolution(before: Solution, title: String, options: [String]) {
        do {
            let new = Solution()
            new.title = title
            new.options.append(objectsIn: options)
            try RealmManager.realm.write {
                before.title = new.title
                before.options.removeAll()
                before.options.append(objectsIn: options)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
