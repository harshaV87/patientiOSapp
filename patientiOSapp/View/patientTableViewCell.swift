//
//  patientTableViewCell.swift
//  patientiOSapp
//
//  Created by Venkata harsha Balla on 11/11/20.
//

import UIKit

class patientTableViewCell: UITableViewCell {

    // protocol implementation for the button action
    weak var delegate : seeDetailsTapped?
    
    // setting aspects of the contentview in each cell
    var patientS: Entry? {
        
        didSet {
            
            let patientName = patientS?.resource?.name?.first?.given?.first
            
            notLabel.text = "Given Name: \(patientName ?? "No Name Available")"
            
        }
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
      
        contentView.addSubview(notLabel)
        contentView.addSubview(rejectButton)
      
        
        setUpViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // programatic view
     let notLabel : UILabel = {
        
        let upLabel = UILabel()
        upLabel.translatesAutoresizingMaskIntoConstraints = false
        upLabel.numberOfLines = 0
        upLabel.textAlignment = .justified
        upLabel.backgroundColor = .systemBlue
        upLabel.textColor = .white
        upLabel.layer.cornerRadius = 10
        upLabel.clipsToBounds = true
    
        return upLabel
        
    }()
    
    // reject button
    
    lazy var rejectButton : UIButton = {
        
             let attBut = UIButton(type: .system)
               attBut.layer.cornerRadius = 5
               attBut.clipsToBounds = true
               
        var buttonImage = UIImage(named: "detail")
        attBut.setBackgroundImage(buttonImage, for: .normal)
        
               attBut.translatesAutoresizingMaskIntoConstraints = false
        attBut.addTarget(self, action: #selector(handleCancelTapped), for: .touchUpInside)
               return attBut
               
        
        
    }()
    

    
    
    // Auto layout
    func setUpViews() {
        
        contentView.backgroundColor = .white
        
        notLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        notLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        notLabel.rightAnchor.constraint(equalTo: rejectButton.leftAnchor).isActive = true
        notLabel.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 1.1).isActive = true
        notLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.height).isActive = true
        
        rejectButton.leftAnchor.constraint(equalTo: notLabel.rightAnchor).isActive = true
        rejectButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        rejectButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        rejectButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rejectButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
    
    // Target actions
    
    @objc func handleCancelTapped() {
        
        delegate?.tapForDetails(forCell: self)
        
        
    }
    

}
