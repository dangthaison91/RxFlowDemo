//
//  FeedListViewModel.swift
//  RxFlowDemo
//
//  Created by sondt on 12/4/17.
//

import Foundation
import RxCocoa
import RxSwift
import RxRealm
import RxFlow

final class ActivityViewModel {
    
    var items: Driver<[ActivitySectionModel]> = Driver.just([])
    
    init() {
        items = DataStore
            .observableObjects(type: Schedule.self)
            .map { schedules in schedules.map { MedicationScheduleCellModel(schedule: $0) } }
            .map { [ActivitySectionModel(model: "", items: $0)] }
            .asDriver(onErrorJustReturn: [])
        
    }
}
