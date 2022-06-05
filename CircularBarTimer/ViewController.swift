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
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.boldSystemFont(ofSize: 84)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
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
        
        view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor)
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
