//
//  ActivityViewController.swift
//  RxFlowDemo
//
//  Created by sondt on 12/4/17.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import RxFlow
import ESTabBarController_swift
import Reusable

typealias ActivitySectionModel = AnimatableSectionModel<String, MedicationScheduleCellModel>

final class ActivityViewController: UIViewController, UITableViewDelegate, Stepper {
    
    let closeCellHeight: CGFloat = 120
    let openCellHeight: CGFloat = 464
    private var cellExpandStates: [IndexPath: Bool] = [:]
    
    // UI
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: RxTableViewSectionedAnimatedDataSource<ActivitySectionModel>!
    
    var viewModel: ActivityViewModel! = ActivityViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureTableView()
        
        let createButton = UIBarButtonItem(title: "Create", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = createButton
        
        createButton
            .rx.tap
            .subscribeNext { [weak self] _ in
                self?.step.accept(ScheduleStep.createSchedule)
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellExpandStates[indexPath].or(false) ? openCellHeight : closeCellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? MedicationScheduleCell else {
            return
        }
        
        if cellExpandStates[indexPath] == true {
            cell.unfold(true, animated: false, completion: nil)
        } else {
            cell.unfold(false, animated: false, completion: nil)
        }
    }
    
    func configureTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.estimatedRowHeight = closeCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = .white

        let configureCell: TableViewSectionedDataSource<ActivitySectionModel>.ConfigureCell = { datasource, tableView, indexPath, model in
            let cell: MedicationScheduleCell = tableView.dequeueReusableCell(for: indexPath)
            
            let durations: [TimeInterval] = [0.3, 0.2, 0.2]
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            return cell
        }
        
        dataSource = RxTableViewSectionedAnimatedDataSource<ActivitySectionModel>(configureCell: configureCell)
        
        viewModel
            .items
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView
            .rx.itemSelected
            .subscribeNext { [weak self] indexPath in
                self?.animateCell(at: indexPath)
            }
            .disposed(by: disposeBag)
        
    }
    
    func animateCell(at indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MedicationScheduleCell else { return }
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsEpanded = cellExpandStates[indexPath].or(false)
        
        if cellIsEpanded {
            cellExpandStates[indexPath] = false
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellExpandStates[indexPath] = true
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { [tableView] in
            tableView?.beginUpdates()
            tableView?.endUpdates()
            }, completion: nil)
    }
    
    func showCreateScheduleScreen() {
        let createScheduleViewController = CreateScheduleViewController()
        let navi = UINavigationController(rootViewController: createScheduleViewController)
        present(navi, animated: true, completion: nil)
    }
}

private extension ActivityViewController {
    func configureViews() {
        tabBarItem = ESTabBarItem(TabbarIrregularityContentView(), title: "", image: Asset.fingerPrint.image, selectedImage: Asset.fingerPrint.image)
    }
}
