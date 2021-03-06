//
//  MainChatViewController.swift
//  chat-app
//
//  Created by Aida Pourshirazi on 3/29/21.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class MainChatViewController: UIViewController {
    
    private let spinner = JGProgressHUD (  style: .dark)
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register( UITableViewCell.self,
                        forCellReuseIdentifier: "cell")
    
        return table
        
    }()
    
    private let noConversationLable:UILabel = {
        
        let lable = UILabel()
        lable.text = "No Conversation"
        lable.textAlignment = .center
        lable.textColor = .gray
        lable.font = .systemFont(ofSize:21, weight: .medium)
        lable.isHidden = true
        return lable
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        Databasemanager.shared.test()
        view.addSubview(tableView)
        view.addSubview(noConversationLable)
        setupTableView()
        fetchConversations()
            
    }
    
    
    
    override func viewDidLayoutSubviews () {
        
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear (animated)
        
        
        validateAuth()
    }
    
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil
        {
                let vc =  LoginViewController()
                let nav = UINavigationController (rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                present( nav, animated: false)
                
            }
        }
    private func setupTableView () {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    private func fetchConversations () {
        tableView.isHidden = false 
        
        
    }
    
    
    
    
}
      

extension MainChatViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for : indexPath)
        
        cell.textLabel?.text = "Hello World this is my first chat"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatoViewController()
        vc.title="Chat"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)

    }
}







    
    

    
    
    
    
    


