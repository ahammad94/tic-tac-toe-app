//
//  ViewController.swift
//  tic tac toe app
//
//  Created by Abdelrahman Hammad on 4/19/17.
//  Copyright © 2017 Abdelrahman Hammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    var turn = 0
    var activeGame = true
    
    //0 is empty, 1 is cricles, 2 is crosses
    var state = [0,0,0,0,0,0,0,0,0]

    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
    
        winnerLabel.center = CGPoint(x: winnerLabel.center.x-500, y: winnerLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x+500, y: playAgainButton.center.y)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playAgain(_ sender: Any) {
        reset()
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        if activeGame {
            var val = 0
            if turn % 2 == 0 {
                sender.setImage(UIImage(named: "nought.png"), for:[])
                val = 1
            }else{
               
                sender.setImage(UIImage(named: "cross.png"), for:[])
                val = 2
                
            }
            sender.isEnabled = false
            state[sender.tag-1] = val
            if checkVictory() {
                winnerLabel.isHidden = false
                playAgainButton.isHidden = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x+500, y: self.winnerLabel.center.y)
                    self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x-500, y:self.playAgainButton.center.y)
                })
            }
        
            turn+=1
        }
        
    }
    
    internal func checkVictory () -> Bool {
        let winningCombination = [[0,1,2], [3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]
        for combination in winningCombination{
            if state[combination[0]] != 0 && state[combination[0]] == state[combination[1]] && state[combination[1]] == state[combination[2]]{
                activeGame = false
                return true
            }
        }
        return false
    }
    
    internal func reset(){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x-500, y: self.winnerLabel.center.y)
            self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x+500, y:self.playAgainButton.center.y)
                self.winnerLabel.isHidden = true
                self.playAgainButton.isHidden = true
        })

        
        activeGame = true
        state = [0,0,0,0,0,0,0,0,0]
        for i in 1..<10{
            if let button = view.viewWithTag(i) as? UIButton{
                button.setImage(nil, for: [])
                button.isEnabled = true
            }
        
        }
        
    }

}

