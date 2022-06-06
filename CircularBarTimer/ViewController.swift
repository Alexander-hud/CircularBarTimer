//
//  ViewController.swift
//  CircularBarTimer
//
//  Created by Александр Алешин on 05.06.2022.
//

import UIKit

class ViewController: UIViewController {

    let lessonLabel: UILabel = {
        let label = UILabel()
        label.text = "My homework swift"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let shapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ellipce")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    let timeLabelMinuts: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let timeLabelTire: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let timeLabelSecond: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Старт", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    var timer = Timer()
    
    let shapeLayer = CAShapeLayer()
    
    var durationTimerMinuts = 24
    var durationTimerSecunds = 60
    
    lazy var fullTime: [Int] = [durationTimerMinuts, durationTimerSecunds]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        
        basicAnimation()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func timerAction() {
        
        durationTimerSecunds -= 1
        timeLabelMinuts.text = "\(durationTimerMinuts)"
        timeLabelSecond.text = "\(durationTimerSecunds)"
        
        repeat {
            if durationTimerSecunds == 0 {
                timer.invalidate()
                durationTimerSecunds = 60
                timer.invalidate()
                durationTimerMinuts -= 1
                timeLabelMinuts.text = "\(durationTimerMinuts)"
                timeLabelSecond.text = "\(durationTimerSecunds)"
            }
        } while durationTimerMinuts == 5

    }
    
    //MARK: Animation
    
    func animationCircular() {
        
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circulePath = UIBezierPath(arcCenter: center, radius: 85, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circulePath.cgPath
        shapeLayer.lineWidth = 25
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeView.layer.addSublayer(shapeLayer)
        
    }
    
    func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimerSecunds)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}

extension ViewController {
    func setConstraints() {
        view.addSubview(lessonLabel)
        NSLayoutConstraint.activate([
            lessonLabel.topAnchor.constraint(equalTo: view.topAnchor, constant:  150),
            lessonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lessonLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(shapeView)
        NSLayoutConstraint.activate([
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 280),
            shapeView.widthAnchor.constraint(equalToConstant: 500)
        ])
        
        view.addSubview(timeLabelMinuts)
        NSLayoutConstraint.activate([
            timeLabelMinuts.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor, constant: -27),
            timeLabelMinuts.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor)
        ])
        
        view.addSubview(timeLabelTire)
        NSLayoutConstraint.activate([
            timeLabelTire.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            timeLabelTire.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor, constant: -2)
        ])
        
        view.addSubview(timeLabelSecond)
        NSLayoutConstraint.activate([
            timeLabelSecond.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor, constant:  27),
            timeLabelSecond.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor)
        ])
        
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
