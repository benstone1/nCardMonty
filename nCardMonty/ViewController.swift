//
//  ViewController.swift
//  nCardMonty
//
//  Created by C4Q  on 7/13/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var brain: MontyBrain? = nil
    
    @IBOutlet weak var buttonContainer: UIView!
    
    
    @IBAction func resetBoard(_ sender: Any) {
        guard let cardNumText = cardNumTextField.text, let cardNum = Int(cardNumText) else {
            return
        }
        buttonContainer.subviews.forEach{$0.removeFromSuperview()}
        brain = MontyBrain(numberOfCards: cardNum)
        setUpButtons(cardNum, with: view.bounds)
    }
    
    @IBOutlet weak var cardNumTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        buttonContainer.subviews.forEach{$0.removeFromSuperview()}
        let newWidth = size.width
        let newHeight = size.height / 2
        setUpButtons(Int(cardNumTextField.text ?? "0")!, with: CGRect(origin: CGPoint.zero, size: CGSize(width: newWidth, height: newHeight)))
    }
    
    private func setUpButtons(_ buttonNum: Int, with buttonContainerRect: CGRect) {
        var xOffSet: CGFloat = 0
        var yOffSet: CGFloat = 0
        for n in 0..<buttonNum {
            let newButton = UIButton()
            newButton.tag = n
            newButton.setTitle("\(n + 1)", for: .normal)
            newButton.titleColor(for: .normal)
            newButton.addTarget(self, action: #selector(handleButtonPushed), for: .touchUpInside)
            buttonContainer.addSubview(newButton)
            newButton.translatesAutoresizingMaskIntoConstraints = false
            newButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: xOffSet).isActive = true
            newButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: yOffSet).isActive = true
            newButton.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor, multiplier: 0.15).isActive = true
            newButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 0.2).isActive = true
            newButton.backgroundColor = UIColor.gray
            xOffSet +=  ((buttonContainerRect.width * 0.15 / 2) + buttonContainerRect.width * 0.15)
            if xOffSet + (buttonContainerRect.width * 0.15) > buttonContainerRect.width {
                yOffSet += (buttonContainerRect.height * 0.2)
                xOffSet = 0
            }
        }
    }
    
    func handleButtonPushed(sender: UIButton!) {
        guard let brain = brain else {
            return
        }
        if brain.isCorrectCard(sender.tag) {
            resultLabel.text = "You Win!"
            print("Win!")
        } else {
            resultLabel.text = "Guess Again!"
        }
    }
}

