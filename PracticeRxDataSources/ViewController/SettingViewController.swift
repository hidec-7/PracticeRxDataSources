//
//  SettingViewController.swift
//  PracticeRxDataSources
//
//  Created by hideto c. on 2021/06/04.
//

import UIKit
import RxSwift
import RxDataSources

class SettingViewController: UIViewController, UIScrollViewDelegate {
    
    private let disposeBag = DisposeBag()
    private var viewModel: SettingViewModel!
    
    // Object
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    // dataSource
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingSectionModel>(configureCell: configureCell)
    private lazy var configureCell: RxTableViewSectionedReloadDataSource<SettingSectionModel>.ConfigureCell = {
        [weak self] (dataSource, tableView, indexPath, _) in
        
        let item = dataSource[indexPath]
        switch item {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility, .credits, .version, .privacyPolicy:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = item.title
            cell.accessoryType = item.accessoryType
            return cell
        case .description(let text):
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = text
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.delegate = self
        
        setupTableView()
        setupViewModel()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset.bottom = 12.0
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let item = self?.dataSource[indexPath] else { return }
                self?.tableView.deselectRow(at: indexPath, animated: true)
                switch item {
                case .account: break
                case .security: break
                case .notification: break
                case .contents: break
                case .sounds: break
                case .dataUsing: break
                case .accessibility: break
                case .description: break
                case .credits: break
                case .version: break
                case .privacyPolicy: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        viewModel = SettingViewModel()
        
        viewModel.items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.updateItems()
    }
}

extension SettingViewController: UINavigationBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        .topAttached
    }
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath]
        return item.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let section = dataSource[section]
        return section.model.footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
