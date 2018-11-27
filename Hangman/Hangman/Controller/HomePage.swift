//
//  HomePage.swift
//  Hangman
//
//  Created by Ashli Rankin on 11/23/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class HomePage: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var MultiPlayerButton: UIButton!
    @IBOutlet weak var animatedHangman: UIButton!
    
    @IBOutlet weak var SinglePlayerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stickFigure" {
          let nextViewController = segue.destination as? HangmanViewController
            nextViewController?.stickImages = [UIImage(named: "hang7"),UIImage(named: "hang6"),UIImage(named: "hang5"),UIImage(named: "hang4"),UIImage(named: "hang3"),UIImage(named: "hang2"),UIImage(named: "hang1")] as! [UIImage]
        }
        else if segue.identifier == "animated" {
            let nextViewController = segue.destination as? HangmanViewController
            nextViewController?.animatedImages = [UIImage(named: "hang7-1"),UIImage(named: "hang6-1"),UIImage(named: "hang5-1"),UIImage(named: "hang4-1"),UIImage(named: "hang3-1"),UIImage(named: "hang2-1"),UIImage(named: "hang1-1")] as! [UIImage]

        }
        
        
    }
   

}
