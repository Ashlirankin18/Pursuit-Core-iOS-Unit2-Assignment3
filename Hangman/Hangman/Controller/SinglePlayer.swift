//
//  SinglePlayer.swift
//  Hangman
//
//  Created by Ashli Rankin on 11/23/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class SinglePlayer: UIViewController {
    @IBOutlet weak var catagoryPicker: UIPickerView!

    
    var hangmanWords = HangmanWordS.catogory
    var keys = String()
    
    var titleForRow = String()
    let category = HangmanWordS.catogory.map { $0.catogories }
    let words = HangmanWordS.catogory.map {$0.words}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catagoryPicker.dataSource = self
        catagoryPicker.delegate = self
    }
    
    }


extension SinglePlayer:UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       titleForRow = category[row]
        return titleForRow
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "pickerViewStoryBoard") as? SinglePlayerGame else {return}
            vc.category = titleForRow
            vc.matrixOfWords = words
        
        present(vc, animated: true, completion: nil)
       
    }
    }

extension SinglePlayer:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return category.count
    }
 
}
