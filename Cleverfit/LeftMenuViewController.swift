//
//  LeftMenuViewController.swift
//  SSASideMenuExample
//
//  Created by Jose Luis Molina on 20/10/14.
//  Copyright (c) 2015 Jose Luis Molina. All rights reserved.
//

import Foundation
import UIKit

class LeftMenuViewController: UIViewController {
    
    let titles: [String] = ["Yo", "Plan actual", "Historial", "Ajustes", "Cerrar sesión"]
    let images: [String] = ["IconHome", "IconCalendar", "IconProfile", "IconSettings", "IconEmpty"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.frame = CGRect(x: 20, y: (self.view.frame.size.height - 54 * 5) / 2.0, width: self.view.frame.size.width, height: 54 * 5)
        tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isOpaque = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}


// MARK : TableViewDataSource & Delegate Methods

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) 

        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 21)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text  = titles[indexPath.row]
        cell.selectionStyle = .none
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
     
        switch indexPath.row {
        case 0:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "meViewController") as UIViewController)
            sideMenuViewController?.hideMenuViewController()
            break
        case 1:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "currentPlanViewController") as UIViewController)
            sideMenuViewController?.hideMenuViewController()
            break
        case 2:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "historyViewController") as UIViewController)
            sideMenuViewController?.hideMenuViewController()
            break
        case 3:
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "settingsViewController") as UIViewController)
            sideMenuViewController?.hideMenuViewController()
            break
        default:
            break
        }
        
        
    }
    
}
    
