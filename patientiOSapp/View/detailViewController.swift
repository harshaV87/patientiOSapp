//
//  detailViewController.swift
//  patientiOSapp
//
//  Created by Venkata harsha Balla on 11/12/20.
//

import UIKit

class detailViewController: UIViewController {
    
    // The entire entry object is injected from the previous view so that we can even parse out even more fields in the future
    var patientObjectPassedOn: Entry?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(familyNameLabel)
        view.addSubview(genderLabel)
        view.addSubview(dobLabel)
        
        setUpView()
        
        SettingFields()
        
    }
    
    // programatic layout
    
    private let familyNameLabel : UILabel = {
        
        let upLabel = UILabel()
        upLabel.translatesAutoresizingMaskIntoConstraints = false
        upLabel.numberOfLines = 0
        upLabel.textAlignment = .center
        upLabel.backgroundColor = .systemBlue
        upLabel.textColor = .white
        upLabel.layer.cornerRadius = 10
        upLabel.clipsToBounds = true
        
        return upLabel
    }()
    
    private let genderLabel : UILabel = {
        
        let upLabel = UILabel()
        upLabel.translatesAutoresizingMaskIntoConstraints = false
        upLabel.numberOfLines = 0
        upLabel.textAlignment = .center
        upLabel.backgroundColor = .systemBlue
        upLabel.textColor = .white
        upLabel.layer.cornerRadius = 10
        upLabel.clipsToBounds = true
        return upLabel
        
    }()
    
    private let dobLabel : UILabel = {
        
        let upLabel = UILabel()
        upLabel.translatesAutoresizingMaskIntoConstraints = false
        upLabel.numberOfLines = 0
        upLabel.textAlignment = .center
        upLabel.backgroundColor = .systemBlue
        upLabel.textColor = .white
        upLabel.layer.cornerRadius = 10
        upLabel.clipsToBounds = true
        return upLabel
        
    }()
    
    // AutoLayout
    func setUpView() {
        familyNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height/2.7).isActive = true
        familyNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80).isActive = true
        familyNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80).isActive = true
        
        genderLabel.topAnchor.constraint(equalTo: familyNameLabel.bottomAnchor, constant: 20).isActive = true
        genderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80).isActive = true
        genderLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80).isActive = true
        
        dobLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20).isActive = true
        dobLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80).isActive = true
        dobLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80).isActive = true
    }
    
    
    // Setting fields from the incoming data 
    func SettingFields() {
        
        let familyTab = patientObjectPassedOn?.resource?.name?.first?.family
        
        let genderTab = patientObjectPassedOn?.resource?.gender
        
        let dobTab = patientObjectPassedOn?.resource?.birthDate
        
        let navTab = patientObjectPassedOn?.resource?.name?.first?.given?.first
        
        familyNameLabel.text = "Family Name: \(familyTab ?? "Not Available")"
        
        genderLabel.text = "Gender: \(genderTab ?? "Not Available")"
        
        dobLabel.text = "DOB: \(dobTab ?? "Not Available")"
        
        navigationItem.title = "Patient Given Name: \(navTab ?? "No Name Available")"
    }

}
