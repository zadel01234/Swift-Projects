//
//  ViewController.swift
//  Onitete App
//
//  Created by Olufayo Emmanuel on 03/02/2026.
//

import UIKit

class ViewController: UIViewController {
    
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0

    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinTheDice()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        spinTheDice()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        spinTheDice()
    }
    
    func spinTheDice(){
        randomDiceIndex1 = Int.random(in: 0 ... 5)
        randomDiceIndex2 = Int.random(in: 0 ... 5)
        
                
        diceImageView1.image = UIImage(named: "dice\(randomDiceIndex1 + 1)")
        
        diceImageView2.image = UIImage(named: "dice\(randomDiceIndex2 + 1)")
    }
    
}

