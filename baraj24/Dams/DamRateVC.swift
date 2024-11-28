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
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 24)
        label.textColor = /*UIColor(resource: .titleLabel)*/ .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    init(dams: AllDams, city: String) {
        super.init(nibName: nil, bundle: nil)
        self.dams = dams
        self.city = city
      
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
        
    
        
        view.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            cityLabel.heightAnchor.constraint(equalToConstant: 30),
            cityLabel.widthAnchor.constraint(equalTo: view.widthAnchor)
            
            
        ])
        
        cityLabel.text = city
        print(city)
        let averageRate = dams.averageRates
        animation.rate.text = String(format: "%% %.2f", averageRate)
        animation.startAnimation(rate: Float(averageRate))

    }
    
}
