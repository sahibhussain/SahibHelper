//
//  TableViewEmptyHelper.swift
//  Exam Kwiz
//
//  Created by sahib hussain on 05/02/20.
//  Copyright © 2020 sahib hussain. All rights reserved.
//

import UIKit


public class TableViewEmptyHelper {
    
    public static let shared = TableViewEmptyHelper()
    var emptyView = UIView()
    var connErrorView = UIView()
    var serverErrorView = UIView()
    var loaderView = UIView()
    
    private init() {}
    
//    MARK: loader view related
    public func showLoaderView(_ tableView: UITableView) {
        let nib = UINib(nibName: "LoaderView", bundle: Bundle.main)
        loaderView = nib.instantiate(withOwner: tableView.self, options: nil)[0] as? UIView ?? UIView()
        loaderView.frame = tableView.frame
        tableView.addSubview(loaderView)
    }
    
    public func showLoaderView(_ view: UIView) {
        let nib = UINib(nibName: "LoaderView", bundle: Bundle.main)
        loaderView = nib.instantiate(withOwner: view.self, options: nil)[0] as? UIView ?? UIView()
        loaderView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loaderView.center = view.center
        view.addSubview(loaderView)
        view.bringSubviewToFront(loaderView)
    }
    
    public func hideLoaderView() {
        loaderView.removeFromSuperview()
    }
    
//    MARK: empty view related
    public func showEmptyView(_ tableView: UITableView) {
        let nib = UINib(nibName: "EmptyView", bundle: Bundle.main)
        emptyView = nib.instantiate(withOwner: tableView.self, options: nil)[0] as? UIView ?? UIView()
        emptyView.frame = tableView.frame
        tableView.addSubview(emptyView)
    }
    
    public func hideEmptyView() {
        emptyView.removeFromSuperview()
    }
    
//    MARK: connection error view related
    public func showConnectionErrorView(_ tableView: UITableView) {
        let nib = UINib(nibName: "ConnectionErrorView", bundle: Bundle.main)
        connErrorView = nib.instantiate(withOwner: tableView.self, options: nil)[0] as? UIView ?? UIView()
        connErrorView.frame = tableView.frame
        tableView.addSubview(connErrorView)
    }
    
    public func hideConnectionErrorView() {
        connErrorView.removeFromSuperview()
    }
    
//    MARK: server error view related
    public func showServerErrorView(_ tableView: UITableView) {
        let nib = UINib(nibName: "ConnectionErrorView", bundle: Bundle.main)
        serverErrorView = nib.instantiate(withOwner: tableView.self, options: nil)[0] as? UIView ?? UIView()
        serverErrorView.frame = tableView.frame
        tableView.addSubview(serverErrorView)
    }
    
    public func hideServerErrorView() {
        serverErrorView.removeFromSuperview()
    }
    
    
//    MARK: all view related
    public func hideAllView() {
        loaderView.removeFromSuperview()
        emptyView.removeFromSuperview()
        connErrorView.removeFromSuperview()
        serverErrorView.removeFromSuperview()
    }
    
}
