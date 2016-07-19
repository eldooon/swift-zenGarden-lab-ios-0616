//
//  ViewController.swift
//  ZenGarden
//
//  Created by Flatiron School on 6/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rakeImage: UIImageView!
    @IBOutlet weak var rockImage: UIImageView!
    @IBOutlet weak var bushImage: UIImageView!
    @IBOutlet weak var swordImage: UIImageView!
    
    var rakeX = NSLayoutConstraint()
    var rakeY = NSLayoutConstraint()
    var rockX = NSLayoutConstraint()
    var rockY = NSLayoutConstraint()
    var bushX = NSLayoutConstraint()
    var bushY = NSLayoutConstraint()
    var swordX = NSLayoutConstraint()
    var swordY = NSLayoutConstraint()
    var rakeDifference = CGPoint()
    var rockDifference = CGPoint()
    var bushDifference = CGPoint()
    var swordDifference = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newGame()
        
        ///enable image interaction
        self.rakeImage.userInteractionEnabled = true
        self.rockImage.userInteractionEnabled = true
        self.bushImage.userInteractionEnabled = true
        self.swordImage.userInteractionEnabled = true
        
        //initiate pan gesture
        let rakedragRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(rakeDragging))
        let rockdragRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(rockDragging))
        let bushdragRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(bushDragging))
        let sworddragRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(swordDragging))
        
        //add gesture recognizer
        self.rakeImage.addGestureRecognizer(rakedragRecognizer)
        self.rockImage.addGestureRecognizer(rockdragRecognizer)
        self.bushImage.addGestureRecognizer(bushdragRecognizer)
        self.swordImage.addGestureRecognizer(sworddragRecognizer)
        
    }

    
    func rakeDragging(recognizer:UIPanGestureRecognizer) {
        let coordinates = recognizer.translationInView(self.rakeImage)
        
        if recognizer.state == .Began {
            self.rakeDifference = coordinates
        } else {
          
            let diffY = coordinates.y - rakeDifference.y
            let diffX = coordinates.x - rakeDifference.x
            
            self.rakeY.constant += diffY
            self.rakeX.constant += diffX
            self.rakeDifference = coordinates
            
            checkWin()
        }
        
    }
    
    func rockDragging(recognizer:UIPanGestureRecognizer) {
        let coordinates = recognizer.translationInView(self.rockImage)
        
        if recognizer.state == .Began {
            self.rockDifference = coordinates
        } else {
            
            let diffY = coordinates.y - rockDifference.y
            let diffX = coordinates.x - rockDifference.x
            
            self.rockY.constant += diffY
            self.rockX.constant += diffX
            self.rockDifference = coordinates
            
            checkWin()
        }
        
    }
    
    func bushDragging(recognizer:UIPanGestureRecognizer) {
        let coordinates = recognizer.translationInView(self.bushImage)
        
        if recognizer.state == .Began {
            self.bushDifference = coordinates
        } else {
            
            let diffY = coordinates.y - bushDifference.y
            let diffX = coordinates.x - bushDifference.x
            
            self.bushY.constant += diffY
            self.bushX.constant += diffX
            self.bushDifference = coordinates
            
            checkWin()
        }
        
    }
    
    func swordDragging(recognizer:UIPanGestureRecognizer) {
        let coordinates = recognizer.translationInView(self.swordImage)
        
        if recognizer.state == .Began {
            self.swordDifference = coordinates
        } else {
            
            let diffY = coordinates.y - swordDifference.y
            let diffX = coordinates.x - swordDifference.x
            
            self.swordY.constant += diffY
            self.swordX.constant += diffX
            self.swordDifference = coordinates
            
            checkWin()
        }
        
    }
    
    func checkWin(){
        
        var correctRakeandBush = false
        var correctRock = false
        var correctSword = false
        var winner = false
        
        if self.swordX.constant < -100.0 && self.swordY.constant > 100 || self.swordY.constant < -100{
            correctSword = true
            print ("Correct Sword!")
        }
        
        if  abs(self.bushDifference.y - self.rakeDifference.y) < 50 && abs(self.bushDifference.x - self.rakeDifference.x) < 50 {
            correctRakeandBush = true
            print ("Correct Rake and Bush!")
        }
        
        if  abs(swordDifference.y - rockDifference.y) > 400 {
            correctRock = true
            print ("Rock!")
        }
        if correctRock && correctRakeandBush && correctSword  {
            winner = true
        }
        
        if winner{
            let alert = UIAlertController(title: "Winner!", message: "CONGRATS", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again?", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            winner = false
            newGame()
        }
    
    }
    
    func newGame(){
        
        //remove constraints
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.removeConstraints(self.view.constraints)
        self.rakeImage.translatesAutoresizingMaskIntoConstraints = false
        self.rakeImage.removeConstraints(self.rakeImage.constraints)
        self.rockImage.translatesAutoresizingMaskIntoConstraints = false
        self.rockImage.removeConstraints(self.rockImage.constraints)
        self.bushImage.translatesAutoresizingMaskIntoConstraints = false
        self.bushImage.removeConstraints(self.bushImage.constraints)
        self.swordImage.translatesAutoresizingMaskIntoConstraints = false
        self.swordImage.removeConstraints(self.swordImage.constraints)
        
        
        //add rake constraints
        self.rakeImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.20).active = true
        self.rakeImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.20).active = true
        self.rakeX = self.rakeImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.rakeX.active = true
        
        self.rakeY = self.rakeImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.rakeY.active = true
        
        //add rock constraints
        self.rockImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.20).active = true
        self.rockImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.20).active = true
        
        self.rockX = self.rockImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.rockX.active = true
        
        self.rockY = self.rockImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.rockY.active = true
        
        //add bush constraints
        self.bushImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.20).active = true
        self.bushImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.20).active = true
        
        self.bushX = self.bushImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.bushX.active = true
        
        self.bushY = self.bushImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.bushY.active = true
        
        //add sword constraints
        self.swordImage.heightAnchor.constraintEqualToAnchor(self.view.heightAnchor, multiplier: 0.20).active = true
        self.swordImage.widthAnchor.constraintEqualToAnchor(self.view.widthAnchor, multiplier: 0.20).active = true
        
        self.swordX = self.swordImage.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.swordX.active = true
        
        self.swordY = self.swordImage.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor, constant: CGFloat(arc4random_uniform(200)))
        self.swordY.active = true


    }
}

