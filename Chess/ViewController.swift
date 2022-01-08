//
//  ViewController.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-06.
//

import UIKit

class ViewController: UIViewController {

    
    // Model:
    var chessEngine: ChessEngine = ChessEngine()
    
    // View:
    @IBOutlet weak var boardView: BoardView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chessEngine.initializeGame()
        boardView.shawdowPiece = chessEngine.pieces
    }


}

