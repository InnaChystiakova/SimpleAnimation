//
//  ViewController.swift
//  SimpleAnimation
//
//  Created by Инна Чистякова on 08.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Constants
    
    let hMargin: CGFloat = 20
    let vMargin: CGFloat = 50
    let side: CGFloat = 75
    let cornerRadius: CGFloat = 8
    
    // MARK: Properties
    
    let simpleView: UIView = UIView()
    let slider: UISlider = UISlider()
    
    var animator: UIViewPropertyAnimator!

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 158/255, alpha: 1.0)
        
        setupSimpleView()
        setupSlider()
        setupAnimator()
        setupConstraints()
    }

    // MARK: Setup
    
    func setupSimpleView() {
        simpleView.layer.cornerRadius = cornerRadius
        simpleView.layer.cornerCurve = .continuous
        simpleView.backgroundColor = UIColor(red: 255/255, green: 95/255, blue: 31/255, alpha: 1.0)
        
        view.addSubview(simpleView)
    }
    
    func setupSlider() {
        slider.minimumTrackTintColor = .systemOrange
        slider.thumbTintColor = .systemOrange
        slider.addTarget(self, action: #selector(self.handleSlider(slider:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(self.animateSlider(slider:)), for: .touchUpInside)

        view.addSubview(slider)
    }
    
    @objc fileprivate func handleSlider(slider: UISlider) {
        animator.fractionComplete = CGFloat(slider.value)
    }
    
    @objc fileprivate func animateSlider(slider: UISlider) {
        animator.pausesOnCompletion = true
        animator.startAnimation()
        slider.setValue(1, animated: true)
    }
        
    func setupAnimator() {
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) { [unowned self] in
            let frame: CGRect = CGRect(
                x: view.frame.size.width - side * 1.5,
                y: view.layoutMargins.top,
                width: side,
                height: side)
            self.simpleView.frame = frame
            self.simpleView.transform = CGAffineTransform(rotationAngle: Double.pi/2).scaledBy(x: 1.5, y: 1.5)
        }
    }
    
    // MARK: Constraints
    
    func setupConstraints() {
        view.layoutMargins = UIEdgeInsets(top: vMargin, left: hMargin, bottom: vMargin, right: hMargin)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        simpleView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            simpleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.layoutMargins.left),
            simpleView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.layoutMargins.top + vMargin),
            simpleView.widthAnchor.constraint(equalToConstant: side),
            simpleView.heightAnchor.constraint(equalToConstant: side),
            
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.layoutMargins.left),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.layoutMargins.right),
            slider.topAnchor.constraint(equalTo: simpleView.bottomAnchor, constant: simpleView.frame.maxY + vMargin),
            slider.heightAnchor.constraint(equalToConstant: vMargin)
        ])
    }
}

