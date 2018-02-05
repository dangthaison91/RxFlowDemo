//
//  CreateScheduleViewModel.swift
//  RxFlowDemo
//
//  Created by dangthaison on 12/25/17.
//

import Foundation
import Action
import RxSwift
import RxCocoa
import RxFlow
import RealmSwift
import SwiftDate

class CreateScheduleViewModel: Stepper {
    var isNew: Bool { return self.id == nil }
    
    let name: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    let notes: BehaviorRelay<String> = BehaviorRelay<String>(value: "")

    let medications = BehaviorRelay<Medication?>(value: nil)
    let dosage = BehaviorRelay<Dosage?>(value: nil)
    let dateType = BehaviorRelay<ScheduleDateType?>(value: nil)

    let days = BehaviorRelay<Set<WeekDay>?>(value: nil)
    let time = BehaviorRelay<Date?>(value: nil)

    private(set) lazy var createAction: Action<Void, Void> = self.createScheduleAction()
    private let id: String?
    private let disposeBag = DisposeBag()
    
    init(id: String?) {
        self.id = id

        createAction
            .elements
            .subscribeNext { [unowned self] in
                self.step.accept(ScheduleStep.scheduleCreated)
            }
            .disposed(by: disposeBag)
        
    }
    
    private func createScheduleAction() -> Action<Void, Void> {
        let strongSelf = self
        return Action<Void, Void> { _ in
            return strongSelf.createSchedule().map { _ in }
        }
    }
}
 // MARK: - APIs
private extension CreateScheduleViewModel {
     func createSchedule() -> Observable<Schedule> {
        let schedule = Schedule()
        schedule.id = (try? Date().timeIntervalSince1970.string()) ?? ""
        schedule.name = name.value
        schedule.notes = notes.value
        schedule.medication = medications.value
        schedule.dosage = dosage.value

        let scheduleTime = ScheduleTime()
        scheduleTime.id = (try? Date().timeIntervalSince1970.string()) ?? ""
        scheduleTime.type = dateType.value
        scheduleTime.date = time.value

        if let weekDay = days.value {
            scheduleTime.days.append(objectsIn: weekDay)
        }
        
        schedule.times.append(scheduleTime)
        DataStore.create(object: scheduleTime, update: true)
        DataStore.create(object: schedule, update: true)
        
        return Observable.just(schedule)
    }
}
