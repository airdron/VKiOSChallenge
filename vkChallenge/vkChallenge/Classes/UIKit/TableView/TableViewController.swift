//
//  TableViewController.swift
//  vkChallenge
//
//  Created by Andrew Oparin on 09/11/2018.
//  Copyright © 2018 Andrew Oparin. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    var scrollView: UIScrollView! { return self.tableView }
    
    var viewModels: [TableSectionViewModel] = []
    var onScroll: ((UIScrollView) -> Void)?
    
    init() {
        super.init(style: .grouped)
        self.tableView.sectionIndexTrackingBackgroundColor = UIColor.clear
        self.tableView.sectionIndexBackgroundColor = UIColor.clear
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels[section].cellModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.viewModels[indexPath.section].cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: viewModel.cellType),
                                                 for: indexPath) as! TableViewCell
        cell.configure(viewModel: viewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = self.viewModels[section].headerViewModel else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewModel.viewType)) as! TableHeaderFooterView
        view.configure(viewModel: viewModel)
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let viewModel = self.viewModels[section].footerViewModel else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: viewModel.viewType)) as! TableHeaderFooterView
        view.configure(viewModel: viewModel)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let viewModel = self.viewModels[section].footerViewModel else { return CGFloat.leastNonzeroMagnitude }
        return viewModel.viewType.height(for: viewModel, tableView: tableView)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let viewModel = self.viewModels[section].headerViewModel else { return CGFloat.leastNonzeroMagnitude }
        return viewModel.viewType.height(for: viewModel, tableView: tableView)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        cell?.didSelect()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        cell?.willSelect()
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = self.viewModels[indexPath.section].cellModels[indexPath.row]
        return viewModel.cellType.height(for: viewModel, tableView: tableView)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.onScroll?(scrollView)
    }
    
    // MARK: Interaction
    func update(viewModels: [TableSectionViewModel]) {
        self.viewModels = viewModels
        self.tableView.reloadData()
    }
    
    func insert(_ cellViewModel: TableCellViewModel,
                for row: Int,
                in section: Int,
                animation: UITableView.RowAnimation = .automatic) {
        self.viewModels[section].cellModels.insert(cellViewModel, at: row)
        let indexPath = IndexPath(row: row, section: section)
        self.tableView.insertRows(at: [indexPath], with: animation)
    }
    
    func append(_ cellViewModels: [TableCellViewModel],
                in section: Int,
                animation: UITableView.RowAnimation = .automatic) {
        let startIndex = self.viewModels[section].cellModels.count
        self.viewModels[section].cellModels.append(contentsOf: cellViewModels)
        let indexPaths = (startIndex..<startIndex + cellViewModels.count).map { return IndexPath(row: $0, section: section) }
        self.tableView.insertRows(at: indexPaths, with: animation)
    }
    
    func update(_ cellViewModel: TableCellViewModel,
                at indexPath: IndexPath,
                animation: UITableView.RowAnimation = .automatic,
                reload: Bool = true) {
        self.viewModels[indexPath.section].cellModels[indexPath.row] = cellViewModel
        if reload {
            self.tableView.reloadRows(at: [indexPath], with: animation)
        }
    }
    
    func update(_ cellViewModel: TableCellViewModel,
                for row: Int,
                in section: Int,
                animation: UITableView.RowAnimation = .automatic,
                reload: Bool = true) {
        let indexPath = IndexPath(row: row, section: section)
        self.update(cellViewModel, at: indexPath, animation: animation, reload: reload)
    }
    
    func delete(_ row: Int,
                in section: Int,
                animation: UITableView.RowAnimation = .fade) {
        self.viewModels[section].cellModels.remove(at: row)
        let indexPath = IndexPath(row: row, section: section)
        self.tableView.deleteRows(at: [indexPath], with: animation)
    }
    
    func move(from fromRow: Int,
              in fromSection: Int,
              to toRow: Int,
              in toSection: Int) {
        let model = self.viewModels[fromSection].cellModels.remove(at: fromRow)
        self.viewModels[toSection].cellModels.insert(model, at: toRow)
        let fromIndexPath = IndexPath(row: fromRow, section: fromSection)
        let toIndexPath = IndexPath(row: toRow, section: toSection)
        self.tableView.moveRow(at: fromIndexPath, to: toIndexPath)
    }
    
    func insert(_ sectionViewModel: TableSectionViewModel,
                in section: Int,
                animation: UITableView.RowAnimation = .automatic) {
        self.viewModels.insert(sectionViewModel, at: section)
        let indexSet = IndexSet(integer: section)
        self.tableView.insertSections(indexSet, with: animation)
    }
    
    func update(_ sectionViewModel: TableSectionViewModel,
                inSection section: Int,
                animation: UITableView.RowAnimation = .automatic,
                reload: Bool = true) {
        self.viewModels[section] = sectionViewModel
        let indexSet = IndexSet(integer: section)
        if reload {
            self.tableView.reloadSections(indexSet, with: animation)
        }
    }
    
    func delete(section: Int,
                animation: UITableView.RowAnimation = .fade) {
        self.viewModels.remove(at: section)
        let indexSet = IndexSet(integer: section)
        self.tableView.deleteSections(indexSet, with: animation)
    }
}
