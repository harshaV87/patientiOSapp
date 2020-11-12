//
//  ViewController.swift
//  patientiOSapp
//
//  Created by Venkata harsha Balla on 11/10/20.
//

import UIKit

class ViewController: UIViewController, seeDetailsTapped {
    
    
    
    let sentnotID = "sentnotifcell"
    
     var arrray = [Entry]()
    
     let notTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableview attached to the normal view, the footer is set to avoid showing the empty rows in the tableview and the seperators are removed for better UI
        
        notTableView.register(patientTableViewCell.self, forCellReuseIdentifier: sentnotID)
        
        notTableView.dataSource = self
        notTableView.delegate = self
        notTableView.tableFooterView = UIView(frame: .zero)
        notTableView.separatorStyle = .none
        view.addSubview(notTableView)
        setUpViews()
        getDataInArray()
        
    }
    
    // Auto Layout with nav bar customisation
    
    func setUpViews() {
        
        // tableview frame
        notTableView.translatesAutoresizingMaskIntoConstraints = false
        
        notTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        notTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        notTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        notTableView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        navigationItem.title = "Patient Names with Details"
    
        
    }
    
    // Data from the network api, with the result parsing
    func getDataInArray() {
        
        NetworkAPI.dataFetch.fetchPostDetail { [weak self] (result) in

            switch result {
            case .success(let post):

                guard  let post = post.entry else {return}

                self?.arrray = post

                DispatchQueue.main.async {

                    self?.notTableView.reloadData()

                }

            case .failure(let error):

                let error = error.localizedDescription

                // for the purpose of simplicity error is printed if the parsing fails
                print(error)
            }

        }
        
    }
    

}


