//
//  ViewController.swift
//  Project 8
//
//  Created by Nadya Postriganova on 15/4/19.
//  Copyright © 2019 Nadya Postriganova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var cluesLabel: UILabel!
  var answerLabel:  UILabel!
  var currentAnswer: UITextField!
  var scoreLabel: UILabel!
  var letterButtons = [UIButton]()
  
  var activatedButtons = [UIButton]()
  var solutions = [String]()
  
  var score = 0 {
    didSet {
      scoreLabel.text = "Score \(score)"
    }
  }
    
  var level = 1
  var correctAnswers = [String]()
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    
    
    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: 0"
    view.addSubview(scoreLabel)
    
    cluesLabel = UILabel()
    cluesLabel.translatesAutoresizingMaskIntoConstraints = false
    cluesLabel.font = UIFont.systemFont(ofSize: 24)
    cluesLabel.text = "CLUE"
    cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    cluesLabel.numberOfLines = 0
    view.addSubview(cluesLabel)
    
    answerLabel = UILabel()
    answerLabel.translatesAutoresizingMaskIntoConstraints = false
    answerLabel.font = UIFont.systemFont(ofSize: 24)
    answerLabel.textAlignment = .right
    answerLabel.text = "ANSWER"
    answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
    answerLabel.numberOfLines = 0
    view.addSubview(answerLabel)
    
    currentAnswer = UITextField()
    currentAnswer.translatesAutoresizingMaskIntoConstraints = false
    currentAnswer.placeholder = "Tap letters to guess"
    currentAnswer.textAlignment = .center
    currentAnswer.font = UIFont.systemFont(ofSize: 43)
    currentAnswer.isUserInteractionEnabled = false
    view.addSubview(currentAnswer)
    
    let submit = UIButton(type: .system)

    submit.layer.borderWidth = 0.5
    submit.layer.cornerRadius = 10
    submit.layer.borderColor = UIColor.lightGray.cgColor
    submit.translatesAutoresizingMaskIntoConstraints = false
    submit.setTitle("SUBMIT", for: .normal)
    submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    view.addSubview(submit)
    
    let clear = UIButton(type: .system)
    clear.layer.borderWidth = 0.5
    clear.layer.cornerRadius = 10
    clear.layer.borderColor = UIColor.lightGray.cgColor
    clear.translatesAutoresizingMaskIntoConstraints = false
    clear.setTitle("CLEAR", for: .normal)
    clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    view.addSubview(clear)
    
    let buttonsView = UIView()
    buttonsView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(buttonsView)
    
    
    NSLayoutConstraint.activate([
      scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
      cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
      answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
      answerLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
      answerLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
      currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
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
        letterButton.layer.borderWidth = 0.5
        letterButton.layer.cornerRadius = 15
        letterButton.layer.borderColor = UIColor.lightGray.cgColor
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        // give the button some temporary text so we can see it on-screen
        letterButton.setTitle("WWW", for: .normal)
        letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
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
 
    DispatchQueue.global(qos: .background).async { [weak self] in
      self?.loadLevel()
    }
  }
  
  @objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
    sender.isHidden = true
    
  }
  
  @objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }
    
    guard let solutionPosition = solutions.firstIndex(of: answerText) else {
      let ac = UIAlertController(title: "Wrong answer.", message: "Please try one more time.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] action in
        self?.score += -1
        self?.clearTapped(sender)
      }))
      present(ac, animated: true)
      return
    }
      
      activatedButtons.removeAll()
      
      var splitAnswers = answerLabel.text?.components(separatedBy: "\n")
      splitAnswers?[solutionPosition] = answerText
      answerLabel.text = splitAnswers?.joined(separator: "\n")
      
      currentAnswer.text = ""
      score += 1
      
      correctAnswers.append(answerLabel.text!)
      if correctAnswers.count == solutions.count {
          let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: self.levelUp))
         present(ac, animated: true)
        
      }
    }
  
  func levelUp(action: UIAlertAction) {
    level += 1
    
    solutions.removeAll(keepingCapacity: true)
    score = 0
    loadLevel()
    
    for button in letterButtons {
      button.isHidden = false
    }
  }
  
  @objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""
    
    for button in activatedButtons {
      button.isHidden = false
    }
    
    activatedButtons.removeAll()
    
  }
  
  @objc func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()
    
    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
      if let levelContents = try? String(contentsOf: levelFileURL) {
        var lines = levelContents.components(separatedBy: "\n")
        lines.shuffle()
        
        for (index, line) in lines.enumerated() {
          let parts = line.components(separatedBy: ": ")
          let answer = parts[0]
          let clue = parts[1]
          
          clueString += "\(index + 1). \(clue)\n"
          
          let solutionWord = answer.replacingOccurrences(of: "|", with: "")
          solutionString += "\(solutionWord.count) letters\n"
          solutions.append(solutionWord)
          
          let bits = answer.components(separatedBy: "|")
          letterBits += bits
        }
        letterBits.shuffle()
      }
    }
    DispatchQueue.main.async {
      [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
      strongSelf.answerLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
      
      if letterBits.count == self?.letterButtons.count {
        for i in 0 ..< strongSelf.letterButtons.count {
          strongSelf.letterButtons[i].setTitle(letterBits[i], for: .normal)
        }
      }
    }
  }
}

