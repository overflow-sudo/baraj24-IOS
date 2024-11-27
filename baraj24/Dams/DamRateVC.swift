//
//  DamRateVC.swift
//  baraj24
//
//  Created by Emir AKSU on 24.11.2024.
//

import UIKit

class DamRateVC: UIViewController {

    
    let animation = EACircleProgress()
    var dams: AllDams!
    var city = String()
    
    init(dams: AllDams) {
        super.init(nibName: nil, bundle: nil)
        self.dams = dams
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(animation)
        NSLayoutConstraint.activate([
        
        
            animation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
    
     
        
        let averageRate = dams.averageRates
        animation.rate.text = String(format: "%% %.2f", averageRate)
        animation.startAnimation(rate: Float(averageRate))
        

    }
    
}
