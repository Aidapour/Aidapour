//
//  NewConversationViewController.swift
//  chat-app
//
//  Created by Aida Pourshirazi on 3/29/21.
//

import UIKit
class NewConversationViewController: UIViewController {
    
    
    
    
    
    public var completion: (([String:String]) -> (Void))?
    
    private var users = [[String:String]]()
    
        
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableView.self, forCellReuseIdentifier: "cell")
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
   
    

}
