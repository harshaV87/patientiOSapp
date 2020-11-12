//
//  VCextension.swift
//  patientiOSapp
//
//  Created by Venkata harsha Balla on 11/12/20.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // main view tableview aspects
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return arrray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = notTableView.dequeueReusableCell(withIdentifier: sentnotID, for: indexPath) as! patientTableViewCell
        
        cell.delegate = self
        
        cell.patientS = arrray[indexPath.row]
        
       
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Patient Given Names"
        
    }
    
    // navigation to the detail controller and passing over the data
    
    func tapForDetails(forCell: patientTableViewCell) {
        
        let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "detailVC") as! detailViewController
        
        nextVC.patientObjectPassedOn = forCell.patientS
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    
}
