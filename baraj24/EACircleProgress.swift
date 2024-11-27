//
//  EACircleProgress.swift
//  baraj24
//
//  Created by Emir AKSU on 23.11.2024.
//

import UIKit
import Lottie

class EACircleProgress: UIView {

    
    let rate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 36)
        label.textColor = .black
        label.text = "%50"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    init(){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(animation)
        NSLayoutConstraint.activate([
            
            animation.leadingAnchor.constraint(equalTo: leadingAnchor),
            animation.trailingAnchor.constraint(equalTo: trailingAnchor),
            animation.topAnchor.constraint(equalTo: topAnchor),
            animation.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            ])
        
        animation.addSubview(rate)
        NSLayoutConstraint.activate([
            
            rate.centerYAnchor.constraint(equalTo: animation.centerYAnchor),
            rate.leadingAnchor.constraint(equalTo: animation.leadingAnchor,constant: 35),
            rate.trailingAnchor.constraint(equalTo: animation.trailingAnchor,constant: -35),
            rate.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var animation: LottieAnimationView = {
       let animation = LottieAnimationView(name: "Animation - 1732445464829")
       animation.translatesAutoresizingMaskIntoConstraints = false
        animation.loopMode = .playOnce
       return animation
    }()
        
    func startAnimation(rate: Float) {
        
        let specificFrame: CGFloat = AnimationFrameTime(rate * 1.2)

        animation.play(fromFrame: 0, toFrame: specificFrame) { (finished) in
        
            if finished {
                self.animation.currentFrame = specificFrame
                
            }
        }
        
        if rate > 60 {
            self.rate.textColor = .black
            UIView.transition(with: self.rate, duration: 1.5, options: .transitionCrossDissolve, animations: {
                self.rate.textColor = .white

            }) {_ in 
            }
        }

    }
    
    
}
