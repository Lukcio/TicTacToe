//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Lucas Leschynski on 7/5/18.
//  Copyright © 2018 Lucas Leschynski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var gridLabel0: GridLabel!
    @IBOutlet weak var gridLabel1: GridLabel!
    @IBOutlet weak var gridLabel2: GridLabel!
    @IBOutlet weak var gridLabel3: GridLabel!
    @IBOutlet weak var gridLabel4: GridLabel!
    @IBOutlet weak var gridLabel5: GridLabel!
    @IBOutlet weak var gridLabel6: GridLabel!
    @IBOutlet weak var gridLabel7: GridLabel!
    @IBOutlet weak var gridLabel8: GridLabel!
    
    var labelsArray = [GridLabel]()
    var xTurn = true
    var winnerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelsArray.append(gridLabel0)
        labelsArray.append(gridLabel1)
        labelsArray.append(gridLabel2)
        labelsArray.append(gridLabel3)
        labelsArray.append(gridLabel4)
        labelsArray.append(gridLabel5)
        labelsArray.append(gridLabel6)
        labelsArray.append(gridLabel7)
        labelsArray.append(gridLabel8)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func onTappedGridLabel(_ sender: UITapGestureRecognizer) {
        for label in labelsArray {
            if label.frame.contains(sender.location(in: backGroundView)) {
                if label.canTap {
                    if xTurn {
                        label.text = "X"
                    } else {
                        label.text = "O"
                    }
                    xTurn = !xTurn
                    label.canTap = false
                    checkWinners()
                }
            }
        }
        if(winnerName != ""){
            let alert = UIAlertController(title: "\(winnerName) won!", message: nil, preferredStyle: .alert)
            let resetAction = UIAlertAction(title: "Reset", style: .default) { (action) in
                for label in self.labelsArray {
                    label.text = ""
                    label.canTap = true
                }
                self.winnerName = ""
            }
            xTurn = true
            alert.addAction(resetAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkWinners() {
        var notDraw = false
        for i in 0...6{
            //print("ran 0..6")
            if(i % 3 == 0){
                if(labelsArray[i].text == labelsArray[i+1].text && labelsArray[i+1].text == labelsArray[i+2].text){
                    winnerName = labelsArray[i].text!
                }
            }
        }
        for i in 0...2{
            //print("ran 0...2")
            if(labelsArray[i].text == labelsArray[i+3].text && labelsArray[i+3].text == labelsArray[i+6].text){
                winnerName = labelsArray[i].text!
            }
        }
        if(labelsArray[0].text == labelsArray[4].text && labelsArray[4].text == labelsArray[8].text){
            //print("ran diagonal a")
            winnerName = labelsArray[0].text!
        }
        if(labelsArray[2].text == labelsArray[4].text && labelsArray[4].text == labelsArray[6].text){
            //print("ran diagonal b")
            winnerName = labelsArray[2].text!
        }
        for i in 0...8{
            if labelsArray[i].text == ""{
                notDraw = true
            }
        }
        if(winnerName == "" && !notDraw){
            let alert = UIAlertController(title: "Draw", message: nil, preferredStyle: .alert)
            let resetAction = UIAlertAction(title: "Reset", style: .default) { (action) in
                for label in self.labelsArray {
                    label.text = ""
                    label.canTap = true
                }
                self.winnerName = ""
                self.xTurn = true
            }
            alert.addAction(resetAction)
            present(alert, animated: true, completion: nil)
        }
    }
}
