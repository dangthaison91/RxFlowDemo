//
//  MedicationScheduleCell.swift
//  RxFlowDemo
//
//  Created by sondt on 12/4/17.
//

import UIKit
import FoldingCell
import RxDataSources
import Reusable

struct MedicationScheduleCellModel: Hashable, IdentifiableType {
    typealias Identity = Int
    
    var identity: Int { return hashValue }
   
    let id: String
    let name: String
    let notes: String

    let medication: String
    let dosage: String
    let time: String

    init(schedule: Schedule) {
        self.id = schedule.id
        self.name = schedule.name
        self.notes = schedule.notes
        self.medication = (schedule.medication?.name).or("")
        self.dosage = (schedule.dosage?.name).or("")
        self.time = (schedule.times.first?.time?.string(custom: "HH:mm")).or("")
    }
    
    var hashValue: Int {
        return id.hashValue
    }
    
    static func == (lhs: MedicationScheduleCellModel, rhs: MedicationScheduleCellModel) -> Bool {
        return lhs.id == rhs.id
    }
}

final class MedicationScheduleCell: FoldingCell, Reusable {

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 4
        foregroundView.layer.masksToBounds = true
        backgroundColor = .white
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setModel(_ model: MedicationScheduleCellModel) {
        
    }

    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.3, 0.2, 0.2]
        return durations[itemIndex]
    }
}
