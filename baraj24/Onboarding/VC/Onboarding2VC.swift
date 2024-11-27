//
//  Onboarding2VC.swift
//  baraj24
//
//  Created by Emir AKSU on 22.11.2024.
//

import UIKit

class Onboarding2VC: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "P4") // Yeni bir görsel adı
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "📊 Verilerle Daha Güçlü!"
        label.font = UIFont(name: "Poppins-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(resource: .titleLabel)
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Güncel verilerle Türkiye'nin baraj doluluk oranlarını analiz edin ve daha bilinçli kararlar alın."
        label.font = UIFont(name: "Poppins-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 5
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Başlayalım", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(resource: .eaBlue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(resource: .eaGray)

        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -80),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 220)
        ])

        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        containerView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        containerView.addSubview(startButton)
        
        // Ekran boyutuna göre dinamik kısıtlamalar
        let screenHeight = UIScreen.main.bounds.height
        let buttonTopPadding: CGFloat = screenHeight > 800 ? 50 : 30 // Büyük ekranlarda daha fazla boşluk
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: buttonTopPadding),
            startButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            startButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            startButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func startTapped() {
        UserDefaults.standard.set(true, forKey: "isOnboardingComplete")
        let vc = UINavigationController(rootViewController: PickCityVC())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
