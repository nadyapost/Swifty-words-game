//
//  ViewController.swift
//  Project 8
//
//  Created by Nadya Postriganova on 15/4/19.
//  Copyright © 2019 Nadya Postriganova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var cluesLable: UILabel!
  var answerLable:  UILabel!
  var currentAnswer: UITextField!
  var scoreLable: UILabel!
  var letterButtons = [UIButton]()
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    
    
    scoreLable = UILabel()
    scoreLable.translatesAutoresizingMaskIntoConstraints = false
    scoreLable.textAlignment = .right
    scoreLable.text = "Score: 0"
    view.addSubview(scoreLable)
    
    cluesLable = UILabel()
    cluesLable.translatesAutoresizingMaskIntoConstraints = false
    cluesLable.font = UIFont.systemFont(ofSize: 24)
    cluesLable.text = "CLUE"
    cluesLable.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    cluesLable.numberOfLines = 0
    view.addSubview(cluesLable)
    
    answerLable = UILabel()
    answerLable.translatesAutoresizingMaskIntoConstraints = false
    answerLable.font = UIFont.systemFont(ofSize: 24)
    answerLable.textAlignment = .right
    answerLable.text = "ANSWER"
    answerLable.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    answerLable.numberOfLines = 0
    view.addSubview(answerLable)
    
    currentAnswer = UITextField()
    currentAnswer.translatesAutoresizingMaskIntoConstraints = false
    currentAnswer.placeholder = "Tap letters to guess"
    currentAnswer.textAlignment = .center
    currentAnswer.font = UIFont.systemFont(ofSize: 43)
    currentAnswer.isUserInteractionEnabled = false
    view.addSubview(currentAnswer)
    
    let submit = UIButton(type: .system)
    submit.translatesAutoresizingMaskIntoConstraints = false
    submit.setTitle("SUBMIT", for: .normal)
    view.addSubview(submit)
    
    let clear = UIButton(type: .system)
    clear.translatesAutoresizingMaskIntoConstraints = false
    clear.setTitle("CLEAR", for: .normal)
    view.addSubview(clear)
    
    let buttonsView = UIView()
    buttonsView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(buttonsView)
    
    
    NSLayoutConstraint.activate([
      scoreLable.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      scoreLable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      cluesLable.topAnchor.constraint(equalTo: scoreLable.bottomAnchor),
      cluesLable.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
      cluesLable.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
      answerLable.topAnchor.constraint(equalTo: scoreLable.bottomAnchor),
      answerLable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
      answerLable.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
      answerLable.heightAnchor.constraint(equalTo: cluesLable.heightAnchor),
      currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentAnswer.topAnchor.constraint(equalTo: cluesLable.bottomAnchor, constant: 20),
      currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
      submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
      submit.heightAnchor.constraint(equalToConstant: 44),
      clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
      clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
      clear.heightAnchor.constraint(equalToConstant: 44),
      buttonsView.widthAnchor.constraint(equalToConstant: 750),
      buttonsView.heightAnchor.constraint(equalToConstant: 320),
      buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
      buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
      ])
    // set some values for the width and height of each button
    let width = 150
    let height = 80
    
    // create 20 buttons as a 4x5 grid
    for row in 0..<4 {
      for coloumn in 0..<5 {
        // create a new button and give it a big font size
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        // give the button some temporary text so we can see it on-screen
        letterButton.setTitle("WWW", for: .normal)
        // calculate the frame of this button using its column and row
        let frame  = CGRect(x: coloumn * width, y: row * height, width: width, height: height)
        letterButton.frame = frame
        buttonsView.addSubview(letterButton)
        letterButtons.append(letterButton)
      }
    }
    
  }
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
}

