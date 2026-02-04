//
//  ViewController.swift
//  04_Magic 8 Ball
//
//  Created by Olufayo Emmanuel on 04/02/2026.
//

import UIKit

class ViewController: UIViewController {
    
    var randomQuestion: Int = 0

    @IBOutlet weak var ballImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asked()
    }

    @IBAction func askButton(_ sender: UIButton) {
        asked()
    }
    
    func asked(){
        randomQuestion = Int.random(in: 1 ... 5)
        
        ballImage.image = UIImage(named: "ball\(randomQuestion)")
        
        print(randomQuestion)
    }
    
}

