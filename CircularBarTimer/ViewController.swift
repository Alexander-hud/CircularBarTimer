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
    
    var timeLabelMinuts: UILabel = {
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
    
    let pauseButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Пауза", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    let resumeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    var timer = Timer()
    let shapeLayer = CAShapeLayer()
    var isPaused = true
    var durationTimerMinuts = 24
    var durationTimerSecunds = 60
    
    lazy var fullTime: [Int] = [durationTimerMinuts, durationTimerSecunds]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.animationCircular(white: UIColor.red)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        resumeButton.addTarget(self, action: #selector(resumeButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func startButtonTapped() {
        basicAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(isWorkTime), userInfo: nil, repeats: true)
    }
   
    @objc func pauseButtonTapped() {
        pauseAnimation()
        timer.invalidate()
        
    }

    @objc func resumeButtonTapped() {
        
        resumeAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(isWorkTime), userInfo: nil, repeats: true)
        
//        if shapeLayer.speed == 0 {
//            resumeButton.isEnabled = true
//        } else {
//            resumeButton.isEnabled = false
//        }
    }
    
    @objc func isWorkTime() {
        startButton.isEnabled = false
        durationTimerSecunds -= 1
        timeLabelMinuts.text = "\(durationTimerMinuts)"
        timeLabelSecond.text = "\(durationTimerSecunds)"
        
        repeat {
            if durationTimerSecunds == 0 {
                durationTimerSecunds = 59
                durationTimerMinuts -= 1
                timeLabelMinuts.text = "\(durationTimerMinuts)"
                timeLabelSecond.text = "\(durationTimerSecunds)"
            }
            
            else if durationTimerMinuts == 5 {
                durationTimerMinuts -= 1
                timeLabelMinuts.text = "\(durationTimerMinuts)"
                timeLabelSecond.text = "\(durationTimerSecunds)"
         }
            
        } while durationTimerMinuts == 0

    }
    
    //MARK: Animation
    
    func animationCircular(white color: UIColor) {
        
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circulePath = UIBezierPath(arcCenter: center, radius: 85, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circulePath.cgPath
        shapeLayer.lineWidth = 25
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        let color = color
//        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeView.layer.addSublayer(shapeLayer)
        
    }


    func pauseAnimation() {
        let pausedTime = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0
        shapeLayer.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime = shapeLayer.timeOffset
        shapeLayer.speed = 1
        shapeLayer.timeOffset = 0
        shapeLayer.beginTime = 0
        let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shapeLayer.beginTime = timeSincePause
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
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 70),
            startButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(pauseButton)
        NSLayoutConstraint.activate([
            pauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -125),
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: 70),
            pauseButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(resumeButton)
        NSLayoutConstraint.activate([
            resumeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            resumeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resumeButton.heightAnchor.constraint(equalToConstant: 70),
            resumeButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
